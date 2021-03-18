SELECT user.email, user.wallet_balance, user.wallet_total_refilled, user.like_total_balance, pack.id as PACK, SUM(pack.price) as SUM_PACK_PRICE, SUM(upl.likes) as SUM_LIKES
FROM `user_pack_log` as upl LEFT JOIN user on upl.user_id = user.id
LEFT JOIN boosterpack as pack on upl.pack_id = pack.id
GROUP BY user.id, pack.id;
