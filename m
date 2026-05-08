Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A27368968;
	Fri,  8 May 2026 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778284788; cv=none; b=QvbgibERmUkH1ZjBZVyPLEOfoH/3jYPY1dS7zqu3qx5xu9Jf6frJtaAs21LNbqG7krJXLaU2f4cvmMWuE3oHW5mZG/tPrMRlLIVJOKKptQvX58nBwnY8zdxF1a/r+dKcncoOn84ONuWNeIDcu0Jm41ykZIs/+Nl6j/O6vFTuQpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778284788; c=relaxed/simple;
	bh=6E40lC76wZ3jjTxH8no/Ylp+eq3ZDV0K1yIevvQs7qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTC55q64DK5ZZGX4rXQ+ymIlCnaMizj4ux/coSoRxJp5xrXXyO3oJGGXaew+I7EclzjwiLdlc9maGSrPRm9Jx6v3mr7ftTIB2KnItSjwugbS+8wcSia+nb8yqDN2XLUVt1awi9z2BKakOg0MMOCiscvthVBWTaRrvIRM3WyI4Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+1mKZab; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+1mKZab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889CEC2BCB0;
	Fri,  8 May 2026 23:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778284787;
	bh=6E40lC76wZ3jjTxH8no/Ylp+eq3ZDV0K1yIevvQs7qg=;
	h=From:To:Cc:Subject:Date:From;
	b=L+1mKZabQLISTkw7nWODy98da8WDOXZyQR22XTd+0vBi7FUtwYK/CjYbP5xHNIt1t
	 NJ+f7NBDajlHuFFsBHn5OAF/Jnw/5kEpdSuMMjR5NxhGAAg1YD4oqDd9EIZzanWKoD
	 9VT4yiMtb2mXo7n4BLMsH4iqTWGTKVDfjnjrmiMS9b0wbpVCSzMQwvCJuvFJlFky3x
	 lhZwYQpIJKmA3s7gZ9Y057NvxTc5OnyWFhyvg4wV/lhv01BL7k+q5JzxSeksBpMkr/
	 SczQYRHb8N/ePmGloZ68qiZjfT2b4e9TO9c60iqw0OXSF9eKZr9rvO1ro23UO3yQZf
	 GH9pWSj9ceG/Q==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.2] sched_ext: Fix ops_cid layout assert
Date: Fri,  8 May 2026 13:59:46 -1000
Message-ID: <20260508235946.215232-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ca1d48a86fab ("sched_ext: Use offsetofend on both sides of the ops_cid
layout assert") replaced sizeof() with offsetofend() to dodge 32-bit
PPC trailing padding, but the resulting check is tautological: with
CID_OFFSET_MATCH(priv, priv) already enforcing offsetof(priv) equality
and @priv being the same type in both structs, the two offsetofends
are equal by construction. The original protection - catching a stray
field added past @priv in sched_ext_ops_cid - is gone.

Anchor on a zero-size __end[] marker appended after @priv. Its offset
sits flush after @priv regardless of trailing struct padding; if a
field is inserted past @priv, __end shifts and the assert fires.

Closes: https://lore.kernel.org/all/20260508215211.0C03AC2BCB0@smtp.kernel.org/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 6 ++----
 kernel/sched/ext_internal.h | 3 +++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f86ee15be7cb..b685f45b4fd0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -10380,11 +10380,9 @@ static int __init scx_init(void)
 	/*
 	 * cid-form must end exactly at @priv - validate_ops() skips
 	 * cpu_acquire/cpu_release for cid-form because reading those fields
-	 * past the BPF allocation would be UB. offsetofend() on both sides
-	 * instead of sizeof() on sched_ext_ops_cid to sidestep trailing
-	 * struct padding (e.g. 32-bit PPC tail-pads ops_cid past @priv).
+	 * past the BPF allocation would be UB.
 	 */
-	BUILD_BUG_ON(offsetofend(struct sched_ext_ops_cid, priv) !=
+	BUILD_BUG_ON(offsetof(struct sched_ext_ops_cid, __end) !=
 		     offsetofend(struct sched_ext_ops, priv));
 #undef CID_OFFSET_MATCH
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 0ed79bd891c7..cd33984cffcf 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -938,6 +938,9 @@ struct sched_ext_ops_cid {
 
 	/* internal use only, must be NULL */
 	void __rcu *priv;
+
+	/* layout end anchor for the BUILD_BUG_ON in scx_init(); keep last */
+	char __end[0];
 };
 
 enum scx_opi {
-- 
2.54.0

