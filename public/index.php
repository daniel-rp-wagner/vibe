<?php

declare(strict_types=1);

require dirname(__DIR__) . '/src/autoload.php';

use App\Config\Env;
use App\Controllers\HealthController;
use App\Controllers\RatingsController;
use App\Database\PdoFactory;
use App\Events\RatingEventDispatcher;
use App\Http\Request;
use App\Http\Response;
use App\Http\Router;
use App\Repositories\ProductRepository;
use App\Repositories\RatingRepository;
use App\Validation\SchemaValidator;

$root = dirname(__DIR__);
Env::load($root . '/.env');

try {
    $pdo = PdoFactory::create();
} catch (Throwable $e) {
    error_log((string) $e);
    http_response_code(500);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode([
        'data' => null,
        'error' => [
            'code' => 'INTERNAL_ERROR',
            'message' => 'Database connection failed',
            'details' => [],
        ],
    ], JSON_THROW_ON_ERROR | JSON_UNESCAPED_UNICODE);
    exit;
}

$schemaDir = $root . DIRECTORY_SEPARATOR . 'schemas';
$validator = new SchemaValidator($schemaDir);
$events = new RatingEventDispatcher();
$ratingRepo = new RatingRepository($pdo);
$productRepo = new ProductRepository($pdo);
$ratingsController = new RatingsController($ratingRepo, $productRepo, $validator, $events);
$healthController = new HealthController($pdo);

$router = new Router();

$router->get('/health', static fn (Request $r) => $healthController->health($r));
$router->get('/ready', static fn (Request $r) => $healthController->ready($r));

$router->post('/api/ratings/(?P<ratingId>\d+)/approve', static fn (Request $r) => $ratingsController->approve($r));
$router->post('/api/ratings/(?P<ratingId>\d+)/reject', static fn (Request $r) => $ratingsController->reject($r));
$router->delete('/api/ratings/(?P<ratingId>\d+)', static fn (Request $r) => $ratingsController->delete($r));
$router->get('/api/ratings/(?P<store>[0-9]{4})/(?P<productId>[A-Za-z0-9_-]+)', static fn (Request $r) => $ratingsController->listForProduct($r));
$router->post('/api/ratings/(?P<store>[0-9]{4})/(?P<productId>[A-Za-z0-9_-]+)', static fn (Request $r) => $ratingsController->create($r));

$request = Request::fromGlobals();

try {
    $response = $router->dispatch($request);
} catch (Throwable $e) {
    error_log((string) $e);
    $response = Response::jsonError(
        [
            'code' => 'INTERNAL_ERROR',
            'message' => 'Internal server error',
            'details' => [],
        ],
        500,
    );
}

$response->send();
