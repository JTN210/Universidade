import java.util.*;
import java.util.concurrent.locks.*;

class Bank {

    private static class Account {
        private int balance;
        Lock l = new ReentrantLock();

        Account(int balance) {
            this.balance = balance;
        }

        int balance() {
            return balance;
        }

        boolean deposit(int value) {
            balance += value;
            return true;
        }

        boolean withdraw(int value) {
            if (value > balance)
                return false;
            balance -= value;
            return true;
        }
    }

    private Map<Integer, Account> map = new HashMap<Integer, Account>();
    private int nextId = 0;
    private Lock l = new ReentrantLock();

    // create account and return account id
    public int createAccount(int balance) {
        Account c = new Account(balance);
        l.lock();
        try {
            int id = nextId;
            nextId += 1;
            map.put(id, c);
            return id;
        } finally {
            l.unlock();
        }
    }

    // close account and return balance, or 0 if no such account
    public int closeAccount(int id) {
        Account c;
        l.lock();
        try {
            c = map.remove(id);
            if (c == null)
                return 0;
            c.l.lock();
            try {
                return c.balance();
            } finally {
                c.l.unlock();
            }
        } finally {
            l.unlock();
        }
    }

    // account balance; 0 if no such account
    public int balance(int id) {
        Account c;
        l.lock();
        try {
            c = map.get(id);
            if (c == null)
                return 0;
            c.l.lock();
            try {
                return c.balance();
            } finally {
                c.l.unlock();
            }
        } finally {
            l.unlock();
        }
    }

    // deposit; fails if no such account
    public boolean deposit(int id, int value) {
        Account c;
        l.lock();
        try {
            c = map.get(id);
            if (c == null)
                return false;
            c.l.lock();
            try {
                return c.deposit(value);
            } finally {
                c.l.unlock();
            }
        } finally {
            l.unlock();
        }
    }

    // withdraw; fails if no such account or insufficient balance
    public boolean withdraw(int id, int value) {
        Account c;
        l.lock();
        try {
            c = map.get(id);
            if (c == null)
                return false;
            c.l.lock();
            try {
                return c.withdraw(value);
            } finally {
                c.l.unlock();
            }
        } finally {
            l.unlock();
        }
    }

    // transfer value between accounts;
    // fails if either account does not exist or insufficient balance
    public boolean transfer(int from, int to, int value) {
        Account cfrom, cto;
        l.lock();
        try {
            cfrom = map.get(from);
            cto = map.get(to);
            if (cfrom == null || cto == null)
                return false;
            if (from < to) {
                cfrom.l.lock();
                cto.l.lock();
            } else {
                cto.l.lock();
                cfrom.l.lock();
            }
        } finally {
            l.unlock();
        }

        try {
            try {
                if (!cfrom.withdraw(value)) {
                    return false;
                }
            } finally {
                cfrom.l.unlock();
            }
            return cto.deposit(value);
        } finally {
            cto.l.unlock();
        }
    }

    // sum of balances in set of accounts; 0 if some does not exist
    public int totalBalance(int[] ids) {
        int total = 0;
        Account[] cs = new Account[ids.length];
        Arrays.sort(ids);
        this.l.lock();
        try {
            for (int i = 0; i < ids.length; i++) {
                Account c = map.get(ids[i]);
                cs[i] = c;
                if (c == null)
                    return 0;
            }
            for (Account c : cs)
                c.l.lock();
        } finally {
            this.l.unlock();
        }
        for (Account c : cs) {
            total += c.balance();
            c.l.unlock();
        }
        return total;
        // try{
        // for(Account c : cs)
        // total += c.balance();
        // return total;
        // } finally{
        // for(Account c:cs)
        // c.l.unlock();
        // }
        // return total;
        // total += c.balance();
    }

}
