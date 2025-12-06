import './style.css'

// Theme Toggle Logic
const themeToggleBtn = document.getElementById('theme-toggle');
const sunIcon = document.getElementById('sun-icon');
const moonIcon = document.getElementById('moon-icon');

// Check initial theme
if (localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
    document.documentElement.classList.add('dark');
} else {
    document.documentElement.classList.remove('dark');
}

themeToggleBtn.addEventListener('click', () => {
    if (document.documentElement.classList.contains('dark')) {
        document.documentElement.classList.remove('dark');
        localStorage.theme = 'light';
    } else {
        document.documentElement.classList.add('dark');
        localStorage.theme = 'dark';
    }
});

// Navbar scroll effect
const navbar = document.getElementById('navbar');
window.addEventListener('scroll', () => {
    if (window.scrollY > 10) {
        navbar.classList.add('bg-white/80', 'dark:bg-dark-bg/80', 'backdrop-blur-md', 'shadow-sm');
        navbar.classList.remove('border-transparent');
        navbar.classList.add('border-gray-200', 'dark:border-white/5');
    } else {
        navbar.classList.remove('bg-white/80', 'dark:bg-dark-bg/80', 'backdrop-blur-md', 'shadow-sm');
        navbar.classList.add('border-transparent');
        navbar.classList.remove('border-gray-200', 'dark:border-white/5');
    }
});
