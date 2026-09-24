Received: from mta0.migadu.com (out-167.mta0.migadu.com [91.218.175.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B8E4BB299
	for <sched-ext@lists.linux.dev>; Thu, 24 Sep 2026 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275696; cv=none; b=M7dFbaZMGeyyZdjv1uLfrqR8GktGvKvjK4K/b1rOCubdZ0Rdi/gEFvVZaX7mImSeQTGgLJYPkh2LxBjTZ9K2YIwyhmumTutsqlgTwhqcPOLso9D+4ZptpoeASsdg78Yp3f5PL6VO0slNizllREq/IohSMHJHvSg4ZaB82MCnF9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275696; c=relaxed/simple;
	bh=jBoLVDijjVY3+JudgElb6XvSda0egt/f17ov+qEY2iY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTjDbu5J1oFTrGePbfkowL936/G2q46fGfLOMZUzxiKn+4CKNN/BkjSv9ZPQXrwoj+3pQpyiO8lc0wfp5qJ+aEMecJdHzxp102s/tWecetYIYGs+MA0f9vhUnUDWwCiAfkKkRJGhpmnFzHVtF8ntinqOPUlH1lQn8oIFSl+F5m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mWTwYqqZ; arc=none smtp.client-ip=91.218.175.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mWTwYqqZ"
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=jBoLVDijjVY3+JudgElb6XvSda0egt/f17ov+qEY2iY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790275671; v=1; x=1790880471;
 b=mWTwYqqZYuxLC+fqWXZZomOqCdenDLf831E+3KfS2jb4nUuNbU4AgA5BlDO0VXJR0pkFpi4T
 djLe+o7XAjoqpYCzKlzTHDj/Ure7TZDQDUzTYcOKlWbGP5piO7eMAF+chznvzxh9bITi6etEwxk
 MqQZ9lwu6X1wtlE0dhUAWdA8=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id 5003015ae02132ac;
	Thu, 24 Sep 2026 18:47:51 +0000
X-Mizu-Trace-ID: 5003015ae02132ac
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	justinstitt@google.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	Thomas Graf <tgraf@suug.ch>,
	nickolay.lysenko@gmail.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	tj@kernel.org
Cc: Usama Arif <usama.arif@linux.dev>
Subject: [PATCH] rhashtable: specialize default comparison for constant parameters
Date: Thu, 24 Sep 2026 11:47:33 -0700
Message-ID: <20260924184733.2317353-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inline lookup and insert helpers receive the rhashtable parameters by
value. With a static const parameter block, key_offset and key_len are
compile-time constants at the call site.

The default comparison throws that information away by reading both fields
back from ht->p. Fixed-size keys consequently load the parameters and call
bcmp() for every object in the bucket, even when the compiler could use
scalar comparisons instead.

The commit "sched_ext: Specialize the DSQ hashtable compare" [1] resulted
in a 2.9x faster DSQ lookup after replacing this path for its u64 key
with a scalar comparison. Doing that through obj_cmpfn requires every
fixed-key user to provide its own callback.

Pass the call-site parameters to rhashtable_compare(), as
rht_key_get_hash() already does. Use them when key_len is a compile-time
constant. Retain the ht->p path for dynamic parameter blocks. A constant
zero key_len continues to take the runtime length from ht->p.key_len.

This specializes the default comparison for all fixed-size users. With
Clang 22 on x86-64, bcmp() disappears from sched_ext, mac80211, NFSd,
TIPC, NFQUEUE, VFS superblock, pidfs, SysV IPC and hardware-breakpoint
table paths. The affected build_policy.o, sta_info.o and nfsd filecache.o
text shrinks by 512, 400 and 352 bytes respectively. Four- and eight-byte
keys become direct scalar comparisons; six-byte MAC addresses become a
four-byte and a two-byte comparison.

Measure the VFS case with ustat() on a mounted ramfs. This exercises
user_get_super() and its super_dev lookup. Across ten interleaved baseline
and patched VM boot pairs, with five 3 million call samples per boot, the
average per-boot median latency drops from 477.2 to 462.6 ns per call, or
3.0%. All ten pairs improved.

No functional change intended.

[1] https://lore.kernel.org/all/20260921171928.1639407-1-usama.arif@linux.dev/

Suggested-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 include/linux/rhashtable.h | 20 +++++++++++++++-----
 lib/rhashtable.c           |  5 +++--
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 57a2a29bef0e8..c9872965b753c 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -598,13 +598,23 @@ static inline void rht_assign_unlock(struct bucket_table *tbl,
 	for (pos = list; pos && rht_entry(tpos, pos, member);		\
 	     pos = rcu_dereference_all(pos->next))
 
-static inline int rhashtable_compare(struct rhashtable_compare_arg *arg,
-				     const void *obj)
+/*
+ * Use constant params from inlined callers to specialize memcmp(). If params
+ * isn't constant, it must be equal to ht->p.
+ */
+static __always_inline int rhashtable_compare(struct rhashtable_compare_arg *arg,
+					      const void *obj,
+					      const struct rhashtable_params params)
 {
 	struct rhashtable *ht = arg->ht;
 	const char *ptr = obj;
 
-	return memcmp(ptr + ht->p.key_offset, arg->key, ht->p.key_len);
+	if (!__builtin_constant_p(params.key_len))
+		return memcmp(ptr + ht->p.key_offset, arg->key,
+			      ht->p.key_len);
+
+	return memcmp(ptr + params.key_offset, arg->key,
+		      params.key_len ? : ht->p.key_len);
 }
 
 /* Internal function, do not use. */
@@ -632,7 +642,7 @@ static __always_inline struct rhash_head *__rhashtable_lookup(
 		rht_for_each_rcu_from(he, __rht_ptr_rcu(bkt, freq), tbl, hash) {
 			if (params.obj_cmpfn ?
 			    params.obj_cmpfn(&arg, rht_obj(ht, he)) :
-			    rhashtable_compare(&arg, rht_obj(ht, he)))
+			    rhashtable_compare(&arg, rht_obj(ht, he), params))
 				continue;
 			return he;
 		}
@@ -797,7 +807,7 @@ static __always_inline void *__rhashtable_insert_fast(
 		if (!key ||
 		    (params.obj_cmpfn ?
 		     params.obj_cmpfn(&arg, rht_obj(ht, head)) :
-		     rhashtable_compare(&arg, rht_obj(ht, head)))) {
+		     rhashtable_compare(&arg, rht_obj(ht, head), params))) {
 			pprev = &head->next;
 			continue;
 		}
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 6362896e4f099..9d9f03b59c823 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -548,7 +548,7 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
 		if (!key ||
 		    (ht->p.obj_cmpfn ?
 		     ht->p.obj_cmpfn(&arg, rht_obj(ht, head)) :
-		     rhashtable_compare(&arg, rht_obj(ht, head)))) {
+		     rhashtable_compare(&arg, rht_obj(ht, head), ht->p))) {
 			pprev = &head->next;
 			continue;
 		}
@@ -710,7 +710,8 @@ static struct rhash_head *__rhashtable_next_in_table(
 		rht_for_each_rcu(he, tbl, b) {
 			bool match = params.obj_cmpfn
 				     ? !params.obj_cmpfn(&arg, rht_obj(ht, he))
-				     : !rhashtable_compare(&arg, rht_obj(ht, he));
+				     : !rhashtable_compare(&arg, rht_obj(ht, he),
+						   params);
 			if (found) {
 				if (match)
 					continue;
-- 
2.53.0-Meta

