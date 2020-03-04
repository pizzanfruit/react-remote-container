import React from 'react';
import { render } from '@testing-library/react';
import TestItem from './test-item';

test('renders test text', () => {
    const { getByText } = render(<TestItem name="testing" />);
    const text = getByText(/TestItem, testing/i);
    expect(text).toBeInTheDocument();
});
