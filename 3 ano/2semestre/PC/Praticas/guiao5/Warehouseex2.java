import java.util.*;
import java.util.concurrent.locks.*;

class Warehouseex2 {
    private final Lock lock = new ReentrantLock();
    private final Map<String, Product> map = new HashMap<>();

    private class Product {
        int quantity = 0;
        Condition cond = lock.newCondition();
    }

    private Product get(String item) {
        Product p = map.get(item);
        if (p != null) return p;
        p = new Product();
        map.put(item, p);
        return p;
    }

    public void supply(String item, int quantity) {
        lock.lock();
        try 
        {
            Product p = get(item);
            p.quantity += quantity;
            p.cond.signalAll();
        } 
        finally
        {
            lock.unlock();
        }
    }

    private Product missing(Product[] prods){
        for (Product p : prods)
        {
            if (p.quantity == 0)
            {
                return p;    
            }
        }
        return null;
    }
    public void consume(Set<String> items) throws InterruptedException {
        lock.lock();
        try 
        {
            Product[] products = new Product[items.size()];
            int i = 0;
            for (String s : items)
            {
                products[i++] = get(s);
            }
            for(;;)
            {
                Product p = missing(products);
                if (p == null)
                {
                 break;   
                }
                p.cond.await();
            }

            for (Product p : products)
            {
             p.quantity--; 
            }
        }   
        finally
        {
            lock.unlock();
        }
    }
}