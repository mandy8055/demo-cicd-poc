// src/App.test.tsx
import { render, screen, fireEvent } from '@testing-library/react';
import App from './App';

describe('App', () => {
  it('renders Vite and React logos', () => {
    render(<App />);
    expect(screen.getByAltText('Vite logo')).toBeInTheDocument();
    expect(screen.getByAltText('React logo')).toBeInTheDocument();
  });

  it('renders the heading', () => {
    render(<App />);
    expect(screen.getByText('Vite + React')).toBeInTheDocument();
  });

  it('renders the initial count', () => {
    render(<App />);
    expect(screen.getByText('count is 0')).toBeInTheDocument();
  });

  it('increments the count on button click', async () => {
    render(<App />);
    const button = screen.getByRole('button');
    await fireEvent.click(button);
    expect(screen.getByText('count is 1')).toBeInTheDocument();
  });
});
