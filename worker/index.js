// ALl configuration/keys for connecting over to redis are stored
const keys = require('./keys');
const redis = require('redis');

const redisClient = redis.createClient({
  host: keys.redisHost,
  port: keys.redisPort,
  // If we lose connection, retry every second
  retry_strategy: () => 1000,
});

const sub = redisClient.duplicate();

// Classic function to fibonacci sequence
// Not ideal however
function fib(index) {
  if (index < 2) return 1;
  return fib(index - 1) + fib(index - 2);
}

// Each time redis get the number
sub.on('message', (channel, message) => {
  // Calculating the resulting fibonacci value
  // And insert it in hset called values
  redisClient.hset('values', message, fib(parseInt(message)));
});
sub.subscribe("insert");
