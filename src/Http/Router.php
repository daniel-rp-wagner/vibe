<?php

declare(strict_types=1);

namespace App\Http;

/**
 * Regex-based router; first match wins.
 */
final class Router
{
    /** @var list<array{method: string, pattern: string, handler: callable}> */
    private array $routes = [];

    /** Register GET route; $pattern is a regex fragment (no delimiters). */
    public function get(string $pattern, callable $handler): void
    {
        $this->add('GET', $pattern, $handler);
    }

    /** Register POST route. */
    public function post(string $pattern, callable $handler): void
    {
        $this->add('POST', $pattern, $handler);
    }

    /** Register DELETE route. */
    public function delete(string $pattern, callable $handler): void
    {
        $this->add('DELETE', $pattern, $handler);
    }

    /** Append a route definition for later dispatch. */
    private function add(string $method, string $pattern, callable $handler): void
    {
        $this->routes[] = ['method' => $method, 'pattern' => $pattern, 'handler' => $handler];
    }

    /** Match first route and invoke handler with named capture attributes. */
    public function dispatch(Request $request): Response
    {
        $path = $request->getPath();
        foreach ($this->routes as $route) {
            if ($route['method'] !== $request->getMethod()) {
                continue;
            }
            $regex = '#^' . $route['pattern'] . '$#';
            if (preg_match($regex, $path, $matches) !== 1) {
                continue;
            }
            $attrs = [];
            foreach ($matches as $k => $v) {
                if (is_string($k)) {
                    $attrs[$k] = $v;
                }
            }
            $handler = $route['handler'];

            return $handler($request->withAttributes($attrs));
        }

        return Response::jsonError(
            [
                'code' => 'INVALID_REQUEST',
                'message' => 'Route not found',
                'details' => ['path' => $path],
            ],
            404,
        );
    }
}
