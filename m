Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792797666;
	b=1VPnG8yr6aPxdBtpTWtqaR4MPYTq3V70l1txRZMQ8YhRGz650ENGjByy70hwPSBwc6lt
	 pzmObZz/HKNQ/359FGA6HlqTxeoepyam/25qfMQD9hQmWGpI/Pzqko1VlNlcjHX4/5b8q
	 93UaPHz3jj6AGS8nhR9BQviXjRhkWl7aE4YVXxogLQijufWsODI6/Xpe/h0TbXfzd3sV/
	 g0qwMMnCCxAYEFqXL0npIAcomdIre9uhzedRtimiikIM/CNSw9vpWfwnTfJUud70+XiFH
	 h+twelHkZNHgNG67Q9uxJViEx9qFMHqXygWxQLBPGhGaMyX9u5A3IqiCxbmFe/i9MkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792797666;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KMg0KVF3ZWVSxxslXVvdaDd3aj4ZmtDGVo8qd6l4NXA=;
	b=JqiWiDjmVx+bzSzGvjzehFpc38SDTusp4UoxOUGLgSXusi5Fg6/8/X35uWOizvZ86cVy
	 RDdnd57oa2+ffkIcQArY+vr+vDp4BAQkcfxNwN0uMwUJTzJwiAThID92XKi4OXVi4zsvM
	 ev8tliX8nwHJm5r5p1yDdDI3dX8oIsLb0u87fZYKN4w2oxUvF5+UTtDNuLivb/bXxNrOD
	 abO5Bs0WbXoKes3lwgmN5Sj54K6wivpH000BZWhFpUQIC9P3qpFnJlbxfNi1IKsaxUXFo
	 qIAaG0+0OBq5DhKazlODjfxL9vzltogEHCgYI+samLUPvDO8z9sfJVp/yC/PDUSqAJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VJ/xs6JQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CE8606A327;
	Fri, 23 Oct 2026 23:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VJ/xs6JQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C671F031E0;
	Fri, 23 Oct 2026 23:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792797665;
	bh=KMg0KVF3ZWVSxxslXVvdaDd3aj4ZmtDGVo8qd6l4NXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VJ/xs6JQIBGALTiKydO/cRvFj+BL/vKz+lRBLBqQqr4FRjGD67Ig1IvXaD1ejXY5d
	 1ShqSuowzGQ5ZNGtZ6wNTAw7oxlejkqA8sN7H26jpHCecbJsm2pc6YAOYxs5HVT9po
	 xBP7hrGQ1hzodyTI9MQ45+sy07y2Fqs2tAAH94ehDUsKSS8B6fJ0Oum3QQ6hOQEtGn
	 XlakBZ6xn0vVZoZhrftc1/zSgG6N9LoSdIUYQl9/pQnmtSE20aDta+QUcsCHMl/dWy
	 1FcuEk8roi6+Zdr6Nal62m+gkQnxcw1yRGalD3z63fCm0ejEFwgOoDcManPoD3nwQl
	 0vieJKL0qxWpg==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/4] sched_ext: Sync tools autogen enum lookup tables from the scx repo
Date: Fri, 23 Oct 2026 13:21:00 -1000
Message-ID: <20261023232102.1124938-3-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023232102.1124938-1-tj@kernel.org>
References: <20261023232102.1124938-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync the two enum lookup tables, enums.autogen.h and enums.autogen.bpf.h,
with the scx repo at a094b6ec68c9 ("scheds/include: Sync with kernel
sched_ext/for-7.5 (b1c2a6b0d90d)").

The kernel copy gains SCX_ENQ_CPU_SELECTED, which scx added in f2fd24198edc
("scheds/include: Add SCX_ENQ_CPU_SELECTED to the enum tables"). The flag's
value changed in 376f8963bbda ("sched: Re-arrange the {EN,DE}QUEUE flags"),
so BPF code should read it from the running kernel.

ebf993609d70 ("sched_ext: Regenerate tools autogen enum headers")
regenerated the other two tables, enum_defs.autogen.h and
enums_abi.autogen.h, from this tree's vmlinux.h. They are newer than scx's
copies and stay as they are.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/enums.autogen.bpf.h | 3 +++
 tools/sched_ext/include/scx/enums.autogen.h     | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tools/sched_ext/include/scx/enums.autogen.bpf.h b/tools/sched_ext/include/scx/enums.autogen.bpf.h
index d0c37018659e..db23be9cc88b 100644
--- a/tools/sched_ext/include/scx/enums.autogen.bpf.h
+++ b/tools/sched_ext/include/scx/enums.autogen.bpf.h
@@ -130,6 +130,9 @@ const volatile u64 __SCX_ENQ_WAKEUP __weak;
 const volatile u64 __SCX_ENQ_HEAD __weak;
 #define SCX_ENQ_HEAD __SCX_ENQ_HEAD
 
+const volatile u64 __SCX_ENQ_CPU_SELECTED __weak;
+#define SCX_ENQ_CPU_SELECTED __SCX_ENQ_CPU_SELECTED
+
 const volatile u64 __SCX_ENQ_PREEMPT __weak;
 #define SCX_ENQ_PREEMPT __SCX_ENQ_PREEMPT
 
diff --git a/tools/sched_ext/include/scx/enums.autogen.h b/tools/sched_ext/include/scx/enums.autogen.h
index c4a7260f0983..369f8d88c7db 100644
--- a/tools/sched_ext/include/scx/enums.autogen.h
+++ b/tools/sched_ext/include/scx/enums.autogen.h
@@ -48,6 +48,7 @@
 	SCX_ENUM_SET(skel, scx_kick_flags, SCX_KICK_ALL_FLAGS); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_WAKEUP); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_HEAD); \
+	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_CPU_SELECTED); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_PREEMPT); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_PREEMPT_LAZY); \
 	SCX_ENUM_SET(skel, scx_enq_flags, SCX_ENQ_IMMED); \
-- 
2.56.0

