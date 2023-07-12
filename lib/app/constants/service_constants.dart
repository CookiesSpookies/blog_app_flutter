// URLS
// const baseURL = 'http://localhost:8001/api';
// php artisan serve --host 192.168.0.161 --port 8001
const baseURL = 'http://192.168.0.161:8001/api';
const loginURL = '$baseURL/login';
const registerURL = '$baseURL/register';
const logoutURL = '$baseURL/logout';
const userURL = '$baseURL/user';
const postURL = '$baseURL/posts';
const commentURL = '$baseURL/comments';

// ERRORS
const serverError = 'Server Error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';