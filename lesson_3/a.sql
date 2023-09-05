-- SELECT events.name, COUNT(tickets.event_id) AS popularity
-- FROM events JOIN tickets
-- ON events.id = tickets.event_id
-- GROUP BY events.name
-- ORDER BY popularity DESC;


SELECT id, email, COUNT(tickets.id)
FROM customers
JOIN tickets
ON customers.id = tickets.customer_id HAVING COUNT(tickets.id) = 3;