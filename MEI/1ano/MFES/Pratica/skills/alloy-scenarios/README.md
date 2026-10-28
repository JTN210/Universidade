# Alloy Scenarios

Generate small, structurally distinct positive and negative Alloy scenarios from model declarations and a natural language requirement. Each scenario is a fully specified Alloy `run` command with explicit scopes, an explanation in a comment, and an `expect` annotation. The skill generates scenarios without formalizing the requirement.

## Choose how to use the skill

This bundle contains a standalone skill folder. How you supply its instructions depends on the mode you use:

| Mode | How to supply the skill |
| --- | --- |
| ChatGPT Work locally, in the desktop app | Install the folder on your computer and ask Work to use its `SKILL.md`. |
| ChatGPT Chat, on the web or in the desktop app | Attach or paste `SKILL.md` and `references/examples.md` into the chat. |
| ChatGPT Work in the cloud, including Work on the web | Attach or paste the same files, or select a separately installed ChatGPT skill or plugin. |

For a skill installed in your home folder, choose **Work locally** in the desktop app. Work on the web runs in a cloud environment; it does not automatically receive that home-folder installation. See [ChatGPT's local and cloud environments](https://learn.chatgpt.com/docs/use-chatgpt).

## Work mode: use the local installation

1. Unzip the archive and copy the whole `alloy-scenarios` folder into `~/.agents/skills/`. Keep the support files together. The main instructions should be at `~/.agents/skills/alloy-scenarios/SKILL.md`.
2. In the ChatGPT desktop app, select ChatGPT, switch to **Work**, and choose **Work locally**.
3. Invoke the available skill, or identify its file directly:

```text
Read and follow the alloy-scenarios skill at
~/.agents/skills/alloy-scenarios/SKILL.md.
```

4. Supply the model declarations, requirement, and scenario counts using the input example below. You may include them in the initial request or send them afterward.

Your Alloy model does not need to exist in the local folder: you can paste its declarations into the message. The folder contains the skill instructions, not a required input model. Local skill locations are described in the [official skill documentation](https://learn.chatgpt.com/docs/build-skills).

## Chat mode: use supplied instructions

Use this route in an ordinary ChatGPT chat on the web or in the desktop app. It also works as a way to supply the instructions to cloud Work.

1. Unzip the archive and open the `alloy-scenarios` folder.
2. Attach [SKILL.md](SKILL.md) and [references/examples.md](references/examples.md) to the conversation if attachments are supported. Alternatively, paste their contents.
3. Ask ChatGPT to follow those instructions:

```text
Follow the attached alloy-scenarios SKILL.md instructions.
Use examples.md as a reference for the Alloy command format.
```

4. Supply the same model declarations, requirement, and scenario counts shown below.

If you pasted the files, use `Follow the alloy-scenarios instructions and examples I pasted above.` instead. In a new conversation, supply the files again unless the skill is available through an installed ChatGPT skill or plugin.

Copying the folder into `~/.agents/skills/` does not by itself install a ChatGPT workspace Skill or plugin for the Chat-mode picker. Local filesystem skills, workspace skills, and plugins have separate installation mechanisms. See [Skill controls](https://learn.chatgpt.com/docs/enterprise/skills).

If **Alloy Scenarios** is already offered in ChatGPT's `@` picker through a supported installation, select it there and provide the inputs. Supplying the files manually is the route for this standalone bundle when no such entry is available. See [explicit skill selection](https://learn.chatgpt.com/docs/build-skills).

## Provide the inputs

Supply:

- Alloy declarations, pasted into the message or provided in a readable model file.
- One requirement in natural language.
- Separate nonnegative integer counts for positive and negative scenarios. The counts may differ or be zero.

No existing model file or special input syntax is required. Once the skill's instructions are available in your conversation, you can send:

```text
Model:
sig Person {
    owns: set Car
}
sig Car {}

Requirement: Every person owns a car.
Positive scenarios: 3
Negative scenarios: 2
```

Replace the example with your own declarations, requirement, and counts. If you provide a model file, replace the pasted declarations with a reference to that file. Include any background constraints or maximum instance size that should apply.

The labels above are convenient, not mandatory. You can give the inputs in plain text, together or across messages. If you invoke the skill without inputs, it should ask:

> Please paste your Alloy declarations and natural language requirement, and tell me how many positive and negative scenarios you want.

Requests for missing information use ordinary language. Once the inputs are complete, the generated scenarios are returned as Alloy code.

## Understand the results

**Review every generated scenario and confirm its expectation against the natural language requirement before adding your formalization as a fact.** Append the scenario commands to a copy of your model containing its declarations and intended background constraints, with the target requirement not yet enforced.

Run each scenario command in the Alloy Analyzer and open the resulting instance in the visualizer. Use the visualized sets and relations to confirm that each positive scenario satisfies the requirement and each negative scenario violates it. This is usually much easier than inspecting the tuple assignments in the commands themselves. Read the explanatory comments alongside the visualization. If a scenario or its classification is wrong, correct or discard it before using it to validate your formalization.

Positive scenarios have `expect 1`; negative scenarios have `expect 0`. Both must be legal under the declarations. **At this review stage, both positive and negative scenarios should produce instances**, even though negative commands carry `expect 0`. The annotation records an expected result and does not add a constraint; these expectations apply once the requirement is enforced. If a command produces no instance before the target requirement is enforced, investigate its consistency with the declarations and background constraints rather than accepting it as a negative scenario.

Only after you have reviewed the visualizations and confirmed all expectations, add your formalization of the requirement as a fact and rerun the commands. Positive scenarios should remain satisfiable and negative scenarios should become unsatisfiable. Defining a predicate alone does not enforce the requirement. Each scenario fixes a complete instance; renaming its atoms does not create a different scenario.

For example, a person with no car is a legal negative scenario for "Every person owns a car" when the field is `owns: set Car`. With `owns: one Car`, that instance violates the declarations; the requirement already follows from the field multiplicity, so valid negative scenarios cannot be generated.

The skill reports which Analyzer or oracle checks were performed; these do not replace your review of the scenarios and their expected classifications. Its examples cover empty populations, subsets, abstract signatures, ternary relations, multiple orderings, and overloaded fields.

## Use with Codex

Copy the whole `alloy-scenarios` folder into `.agents/skills/` inside your project, or `~/.agents/skills/` in your home directory. Keep its support files together. Invoke `$alloy-scenarios` and supply the same inputs. If the skill does not appear after installation, restart Codex. See [local skill discovery](https://learn.chatgpt.com/docs/build-skills).
