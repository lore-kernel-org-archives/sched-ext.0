Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BA923FC49;
	Thu, 27 Nov 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258498; cv=none; b=Nc/o3QHOEpFf7N75SK1YB1nMo5ajt65Pjh708sqh54yTGC/RkhsuHxzbKlnelKnduSJWW2+ZFs+nFnQvF/KJdhOR6TtN+8RHCqmY5behbykbxwrHo4WfTNj5OMKp239aUaCdyn7GKqyVcbiun2Ha3DXubfO07duKbVilF5CAy7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258498; c=relaxed/simple;
	bh=L2jzblJ+afbzlrTgHkDr+6hdkw0/qrq0KUnJRIkILYk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ReXiFGO7I0GYzhWnwvaJRfh9Z/sdT/GJfcmlCm+bSwQE1wd25LCkU4A8E0zwkvcEQwmSLKamGWwSaabMaYypv3XxtfpuUK4KO3IYqMNFeJA73l/erCWon9qAVmVk5FBjpVZM0QyHZJB5d9XphnfNet5Ts5dPyHbypcQ7kyNEGbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SEZ7mukv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SEZ7mukv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=zx2bkb6yotfEr78Kete+RE8vdT5QIVglwHNqAufMUdo=; b=SEZ7mukvNBpy5vBtug6Oi9tczL
	B7+UToCeHfOEm+Oym6uva8Xhytm6inS5hYR0FIOmhG97KV9vIIlv9kSqWjWlwBSKQoZBRhWb9hTbl
	R/Zl7JXVcqbC5YckoSPldFMsRyQhyVgMKpviSvI8wvTRcbvso4EfcztX/pfL/zwdJPNDhTSOqFL6M
	/gDHrTLO00E11vClcFz41A1ZBNCXeiGhpjUCGrjjmCqKlX7f4C9/PI53Wd57MPN9AjijKamUoEx2P
	gqzrz6ioJ1pb8glBQ7wqNP6Zz4JRdRiqF5apRR5r/1KkpymHj3xcNpu1BFJ5dRDJSlopFJflvV+A9
	h4r2P3Hg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOdMT-0000000AP1x-3KbK;
	Thu, 27 Nov 2025 14:52:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id A6725300413; Thu, 27 Nov 2025 16:48:06 +0100 (CET)
Message-ID: <20251127154725.413564507@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 27 Nov 2025 16:39:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 sched-ext@lists.linux.dev
Subject: [PATCH 1/5] sched/fair: Fold the sched_avg update
References: <20251127153943.696191429@infradead.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Nine (and a half) instances of the same pattern is just silly, fold the lot.

Notable, the half instance in enqueue_load_avg() is right after setting
cfs_rq->avg.load_sum to cfs_rq->avg.load_avg * get_pelt_divider(&cfs_rq->avg).
Since get_pelt_divisor() >= PELT_MIN_DIVIDER, this ends up being a no-op
change.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/compiler_types.h |   19 +++++++
 kernel/sched/fair.c            |  108 ++++++++++++-----------------------------
 2 files changed, 51 insertions(+), 76 deletions(-)

--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -558,6 +558,25 @@ struct ftrace_likely_data {
 			 __scalar_type_to_expr_cases(long long),	\
 			 default: (x)))
 
+/*
+ * __signed_scalar_typeof(x) - Declare a signed scalar type, leaving
+ *			       non-scalar types unchanged.
+ */
+
+#define __scalar_type_to_signed_cases(type)				\
+		unsigned type:	(signed type)0,				\
+		signed type:	(signed type)0
+
+#define __signed_scalar_typeof(x) typeof(				\
+		_Generic((x),						\
+			 char:	(signed char)0,				\
+			 __scalar_type_to_signed_cases(char),		\
+			 __scalar_type_to_signed_cases(short),		\
+			 __scalar_type_to_signed_cases(int),		\
+			 __scalar_type_to_signed_cases(long),		\
+			 __scalar_type_to_signed_cases(long long),	\
+			 default: (x)))
+
 /* Is this type a native word size -- useful for atomic operations */
 #define __native_word(t) \
 	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3693,7 +3693,7 @@ account_entity_dequeue(struct cfs_rq *cf
  */
 #define add_positive(_ptr, _val) do {                           \
 	typeof(_ptr) ptr = (_ptr);                              \
-	typeof(_val) val = (_val);                              \
+	__signed_scalar_typeof(*ptr) val = (_val);              \
 	typeof(*ptr) res, var = READ_ONCE(*ptr);                \
 								\
 	res = var + val;                                        \
@@ -3705,23 +3705,6 @@ account_entity_dequeue(struct cfs_rq *cf
 } while (0)
 
 /*
- * Unsigned subtract and clamp on underflow.
- *
- * Explicitly do a load-store to ensure the intermediate value never hits
- * memory. This allows lockless observations without ever seeing the negative
- * values.
- */
-#define sub_positive(_ptr, _val) do {				\
-	typeof(_ptr) ptr = (_ptr);				\
-	typeof(*ptr) val = (_val);				\
-	typeof(*ptr) res, var = READ_ONCE(*ptr);		\
-	res = var - val;					\
-	if (res > var)						\
-		res = 0;					\
-	WRITE_ONCE(*ptr, res);					\
-} while (0)
-
-/*
  * Remove and clamp on negative, from a local variable.
  *
  * A variant of sub_positive(), which does not use explicit load-store
@@ -3732,21 +3715,37 @@ account_entity_dequeue(struct cfs_rq *cf
 	*ptr -= min_t(typeof(*ptr), *ptr, _val);		\
 } while (0)
 
+
+/*
+ * Because of rounding, se->util_sum might ends up being +1 more than
+ * cfs->util_sum. Although this is not a problem by itself, detaching
+ * a lot of tasks with the rounding problem between 2 updates of
+ * util_avg (~1ms) can make cfs->util_sum becoming null whereas
+ * cfs_util_avg is not.
+ *
+ * Check that util_sum is still above its lower bound for the new
+ * util_avg. Given that period_contrib might have moved since the last
+ * sync, we are only sure that util_sum must be above or equal to
+ *    util_avg * minimum possible divider
+ */
+#define __update_sa(sa, name, delta_avg, delta_sum) do {	\
+	add_positive(&(sa)->name##_avg, delta_avg);		\
+	add_positive(&(sa)->name##_sum, delta_sum);		\
+	(sa)->name##_sum = max_t(typeof((sa)->name##_sum),	\
+			       (sa)->name##_sum,		\
+			       (sa)->name##_avg * PELT_MIN_DIVIDER); \
+} while (0)
+
 static inline void
 enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	cfs_rq->avg.load_avg += se->avg.load_avg;
-	cfs_rq->avg.load_sum += se_weight(se) * se->avg.load_sum;
+	__update_sa(&cfs_rq->avg, load, se->avg.load_avg, se->avg.load_sum);
 }
 
 static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	sub_positive(&cfs_rq->avg.load_avg, se->avg.load_avg);
-	sub_positive(&cfs_rq->avg.load_sum, se_weight(se) * se->avg.load_sum);
-	/* See update_cfs_rq_load_avg() */
-	cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
-					  cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
+	__update_sa(&cfs_rq->avg, load, -se->avg.load_avg, -se->avg.load_sum);
 }
 
 static void place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags);
@@ -4239,7 +4238,6 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq
 	 */
 	divider = get_pelt_divider(&cfs_rq->avg);
 
-
 	/* Set new sched_entity's utilization */
 	se->avg.util_avg = gcfs_rq->avg.util_avg;
 	new_sum = se->avg.util_avg * divider;
@@ -4247,12 +4245,7 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq
 	se->avg.util_sum = new_sum;
 
 	/* Update parent cfs_rq utilization */
-	add_positive(&cfs_rq->avg.util_avg, delta_avg);
-	add_positive(&cfs_rq->avg.util_sum, delta_sum);
-
-	/* See update_cfs_rq_load_avg() */
-	cfs_rq->avg.util_sum = max_t(u32, cfs_rq->avg.util_sum,
-					  cfs_rq->avg.util_avg * PELT_MIN_DIVIDER);
+	__update_sa(&cfs_rq->avg, util, delta_avg, delta_sum);
 }
 
 static inline void
@@ -4278,11 +4271,7 @@ update_tg_cfs_runnable(struct cfs_rq *cf
 	se->avg.runnable_sum = new_sum;
 
 	/* Update parent cfs_rq runnable */
-	add_positive(&cfs_rq->avg.runnable_avg, delta_avg);
-	add_positive(&cfs_rq->avg.runnable_sum, delta_sum);
-	/* See update_cfs_rq_load_avg() */
-	cfs_rq->avg.runnable_sum = max_t(u32, cfs_rq->avg.runnable_sum,
-					      cfs_rq->avg.runnable_avg * PELT_MIN_DIVIDER);
+	__update_sa(&cfs_rq->avg, runnable, delta_avg, delta_sum);
 }
 
 static inline void
@@ -4346,11 +4335,7 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq
 
 	se->avg.load_sum = runnable_sum;
 	se->avg.load_avg = load_avg;
-	add_positive(&cfs_rq->avg.load_avg, delta_avg);
-	add_positive(&cfs_rq->avg.load_sum, delta_sum);
-	/* See update_cfs_rq_load_avg() */
-	cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
-					  cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
+	__update_sa(&cfs_rq->avg, load, delta_avg, delta_sum);
 }
 
 static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum)
@@ -4549,33 +4534,13 @@ update_cfs_rq_load_avg(u64 now, struct c
 		raw_spin_unlock(&cfs_rq->removed.lock);
 
 		r = removed_load;
-		sub_positive(&sa->load_avg, r);
-		sub_positive(&sa->load_sum, r * divider);
-		/* See sa->util_sum below */
-		sa->load_sum = max_t(u32, sa->load_sum, sa->load_avg * PELT_MIN_DIVIDER);
+		__update_sa(sa, load, -r, -r*divider);
 
 		r = removed_util;
-		sub_positive(&sa->util_avg, r);
-		sub_positive(&sa->util_sum, r * divider);
-		/*
-		 * Because of rounding, se->util_sum might ends up being +1 more than
-		 * cfs->util_sum. Although this is not a problem by itself, detaching
-		 * a lot of tasks with the rounding problem between 2 updates of
-		 * util_avg (~1ms) can make cfs->util_sum becoming null whereas
-		 * cfs_util_avg is not.
-		 * Check that util_sum is still above its lower bound for the new
-		 * util_avg. Given that period_contrib might have moved since the last
-		 * sync, we are only sure that util_sum must be above or equal to
-		 *    util_avg * minimum possible divider
-		 */
-		sa->util_sum = max_t(u32, sa->util_sum, sa->util_avg * PELT_MIN_DIVIDER);
+		__update_sa(sa, util, -r, -r*divider);
 
 		r = removed_runnable;
-		sub_positive(&sa->runnable_avg, r);
-		sub_positive(&sa->runnable_sum, r * divider);
-		/* See sa->util_sum above */
-		sa->runnable_sum = max_t(u32, sa->runnable_sum,
-					      sa->runnable_avg * PELT_MIN_DIVIDER);
+		__update_sa(sa, runnable, -r, -r*divider);
 
 		/*
 		 * removed_runnable is the unweighted version of removed_load so we
@@ -4660,17 +4625,8 @@ static void attach_entity_load_avg(struc
 static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	dequeue_load_avg(cfs_rq, se);
-	sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
-	sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
-	/* See update_cfs_rq_load_avg() */
-	cfs_rq->avg.util_sum = max_t(u32, cfs_rq->avg.util_sum,
-					  cfs_rq->avg.util_avg * PELT_MIN_DIVIDER);
-
-	sub_positive(&cfs_rq->avg.runnable_avg, se->avg.runnable_avg);
-	sub_positive(&cfs_rq->avg.runnable_sum, se->avg.runnable_sum);
-	/* See update_cfs_rq_load_avg() */
-	cfs_rq->avg.runnable_sum = max_t(u32, cfs_rq->avg.runnable_sum,
-					      cfs_rq->avg.runnable_avg * PELT_MIN_DIVIDER);
+	__update_sa(&cfs_rq->avg, util, -se->avg.util_avg, -se->avg.util_sum);
+	__update_sa(&cfs_rq->avg, runnable, -se->avg.runnable_avg, -se->avg.runnable_sum);
 
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 


