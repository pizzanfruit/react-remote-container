import React from 'react';
import styles from './test-item.module.scss';

export interface Props {
    name: string;
}

function TestItem(props: Props): React.ReactElement {
    return <div className={styles.test}>TestItem, {props.name}!</div>;
}

export default TestItem;
