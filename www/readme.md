# Browser REST client _using the platform only_

This project implements a pure Typescript REST - Client implemented without any
foreign UI-libraries (no Angular, no Vuejs, no React, no Redux, no lit-html, no Polymer...).
The example shows how to implement the [Model View Controller Architecture](https://aberger.at/blog/architecture/javafx/2019/10/26/mvc-pattern-javafx.html) in a browser client application.

The example makes use of [Custom Elements](https://developer.mozilla.org/en-US/docs/Web/Web_Components/Using_custom_elements) and the [Shadow DOM](https://developer.mozilla.org/en-US/docs/Web/Web_Components/Using_shadow_DOM). Both are implemented natively in all popular browsers that we are interested in, so this gives optimal performance.
Other browsers are shimmed by using webcomponents.

We do mix two simple things: mutation and asynchronicity that - when mixed together - 
can behave like [menthos and coke](https://www.youtube.com/watch?v=ZwyMcV9emmc). For Details see this [blog post](https://aberger.at/blog/typescript/mvc/2021/05/23/immutable-state.html).


To avoid all that we use [Observables](http://reactivex.io/)
and make use of 3 fundamental design principles:
- Single source of truth
- Read Only State
- Changes are made with pure functions

We use Typescript to implement this, but without the heavy overhead that would be neccessary with libraries like Redux or Immutablejs.
Although we do not use Redux, we use [immer](https://immerjs.github.io/immer/) for implemening
the producers for our read only application state.


See [model.ts](./src/model/model.ts) and [store.ts](./src/model/store.ts) in the project as an example.

You should propably install an [extension](https://marketplace.visualstudio.com/items?itemName=Tobermory.es6-string-html) to get the syntax highlighting for the html templates in your code editor.

