/// <reference path="../../typings/tsd.d.ts" />
import {component} from 'cycle-react';
import * as React from 'react';
import * as ReactDOM from 'react-dom';

const Hello = component('Hello', (interactions) => {
    return interactions.get('OnNameChanged')
        .map(ev => ev.target.value)
        .startWith('')
        .map(name =>
            <div>
                <label>Name:</label>
                <input type="text" onChange={interactions.listener('OnNameChanged')} />
                <hr/>
                <h1>Hello {name}</h1>
            </div>
        );
});

ReactDOM.render(
    <Hello />,
    document.querySelector('#app')
);