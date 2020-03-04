import React from 'react';
import ReactDOM from 'react-dom';

import TestItem from './components/test-item/test-item';
import './index.css';

declare global {
    interface Window {
        renderReact: Function;
    }
}

window.renderReact = (name: string): void => {
    const div = document.createElement('div');
    document.body.appendChild(div);
    ReactDOM.render(<TestItem name={name} />, div);
};
