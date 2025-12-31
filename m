Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99A52BDC10
	for <sched-ext@lists.linux.dev>; Wed, 31 Dec 2025 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202647; cv=none; b=Fasz4u8NEOVj1jymuEJz+NOgksxxSFY/mjrmUQndIhapsl4CSX2t91Sr69450HcHw6GHrVFCJnYEKdFpXt9WdKXyoGCPiGLsH+S/fDWarnlMgCqvUHHQf+yx5fhsB6JgE3oQ3oDFRZKwtY3NqGckwE3wysGN1uYDkEclHiQvfx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202647; c=relaxed/simple;
	bh=+qs2O0p6JSmasUPfUb0PrNjt2zEzZFmnX/PzeN+aGlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPvNxYICYchAg5V2aXMmMo0666mz9vy5ENzwyhyX9KFzIMSsSe33lwtgynI3b0b3PFQm1G3P/zRhzcMC0iQHeCg4F5F9uFi2zg6QWhD+cQ5NhBEZZmJsb8SnersNHDnYHdKEF9AodkRJvWvJrnrGu59vUTlPXPUHd2MHTOt6Iak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ti2rL+EI; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ti2rL+EI"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-34ce100aec4so974483a91.0
        for <sched-ext@lists.linux.dev>; Wed, 31 Dec 2025 09:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767202644; x=1767807444; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evGP5W8eaS0gGQmtryNYpPPxNCoy7QWmqYRyuLboZRo=;
        b=Ti2rL+EIABYapLMHNafLM+xrHEo3opfVbT9l9LCo3S3ZAvoWDabewSeI3W6a+Fo58Q
         HlUIaRlP5PQ03W9U7jHt+zAMyS7UkGuyPRXNrszSSY0ILWOWwPy0ImtV+BVpodOCtdYW
         Ibp16HbNSpStTjr6/8CduZKwcSVAQ0KC53Q/XPt+2JQb90wiVjUTen0caAE7TjCOay4W
         EAoTjtTRTOMJ2394ZHmGf2YvGNt0nJzTZ5UCLO/4Ys7oegMor4A+d3Ud32jBC6TxiOKo
         c5pKCBgr3Rk8x1+nxsrU6+SXc2dInHjsxOXGxX/SXG4+ZORmlUdGhcGHfDmckCLjrss7
         fv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202644; x=1767807444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=evGP5W8eaS0gGQmtryNYpPPxNCoy7QWmqYRyuLboZRo=;
        b=R1WXhLOpQXT0xN0kYrmH1zzrHLDzPYB0EuwC+mUBjQzoq6/43UjGVV55zLmUPelwdq
         V6JjAG5B9dbgbODE9r8Cami2EnskyWDrHVrnjXhknYQllY1nggZDfqfJ5rXIcpkRbgli
         6kv9vRfkFbF6sSIZG442OUGWLy/HZt5THG14l9S4vg03QnU9eqSjAEkKtjcWGSyE9b7Y
         rg38w9eEs4PtEEBazMR+bDK1iiX4FK4imJbRN/9y0GAwzmPTQ+DGAMvdWlXH3JmRBkNL
         FGlDKWMmWWlcFmRu+FfzLf1RxIr4gwxrmavIXKMpiOyZ6hFXeonlfXdolD4g6IWHcKpX
         zIJw==
X-Forwarded-Encrypted: i=1; AJvYcCUvyJgUYHPHea4jeW15J+vFfVrdsqPRNbfPEUa6EKVxguz027BufrNxDiWJ9pYMp+4Z6rrxSqyXYlA=@lists.linux.dev
X-Gm-Message-State: AOJu0YyKxE0hJYhjFEwaNuALBtjySp7UTL17Zmy+j/89j2YQfvkyX7K+
	yqXSnIWKgGemQiIiWXIigXTvjAApUVHJ3TitySHbZa/MTKFXjHpEGYI1mfgTDtdCBFZp0Ac9IaS
	bn+P2El4ykDlvuXj1FYBWKS/CMLa9RXn/1LwXZyA4s+5tyhNzkWJI
X-Gm-Gg: AY/fxX6obs0VP5mERqQyHrf55w06h6aDpCouD9bkw5vxkMQibv0acslO0L/WVDbej/z
	+DuH4pbj5nW5pjEBM08GWvnVN7M2DRoNldKrGSHZuZV2fdpFyU14Ndc4Jb1ARy619cZS7rABcFM
	MJcx9cRoIGIBP4LKCIblOdrP7GmbIPzNZ/60VsrhYI1BfJLHEs+Iwj196zJ3so98hUcsE5yW7QD
	LgciokAjCcPjuQm+tlFitrFQ6Fm2cSs5fTR4jTaI+7xAhZcd+kPR+Vl7Qbk3gIzM3/5nIXGoqr7
	86DPjVlck9pJWL7lyTB9rlb97AwZAvc6oj7k2+x1ms6Yl0RSZay+uyebqJzxyxWnw6JH+biRxEX
	ird7UxtnemBB3yaIfLn54+bcYIiA=
X-Google-Smtp-Source: AGHT+IE23PFN99NQKL9O+zJCZJj+5szPasN7ULi0swfy4CNHFw+Olu7RghBbYFrAySDYSvrr9RuRB4qHunQX
X-Received: by 2002:a17:90b:3903:b0:341:88ba:c632 with SMTP id 98e67ed59e1d1-34e91f702ccmr23041237a91.0.1767202644137;
        Wed, 31 Dec 2025 09:37:24 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c1e7b784812sm2287052a12.9.2025.12.31.09.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:37:24 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C9BDA340681;
	Wed, 31 Dec 2025 10:37:22 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C3D39E4234A; Wed, 31 Dec 2025 10:37:22 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 5/5] selftests/bpf: make cfi_stubs globals const
Date: Wed, 31 Dec 2025 10:36:33 -0700
Message-ID: <20251231173633.3981832-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251231173633.3981832-1-csander@purestorage.com>
References: <20251231173633.3981832-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that struct bpf_struct_ops's cfi_stubs field is a const pointer,
declare the __test_no_cif_ops, __bpf_testmod_ops*, st_ops_cfi_stubs, and
multi_st_ops_cfi_stubs global variables it points to as const. This
tests that BPF struct_ops implementations are allowed to declare
cfi_stubs global variables as const.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 .../testing/selftests/bpf/test_kmods/bpf_test_no_cfi.c |  2 +-
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c   | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_test_no_cfi.c b/tools/testing/selftests/bpf/test_kmods/bpf_test_no_cfi.c
index 948eb3962732..1d76912f1a45 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_test_no_cfi.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_test_no_cfi.c
@@ -39,11 +39,11 @@ static void bpf_test_no_cfi_ops__fn_1(void)
 
 static void bpf_test_no_cfi_ops__fn_2(void)
 {
 }
 
-static struct bpf_test_no_cfi_ops __test_no_cif_ops = {
+static const struct bpf_test_no_cfi_ops __test_no_cif_ops = {
 	.fn_1 = bpf_test_no_cfi_ops__fn_1,
 	.fn_2 = bpf_test_no_cfi_ops__fn_2,
 };
 
 static struct bpf_struct_ops test_no_cif_ops = {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 90c4b1a51de6..5e460b1dbdb6 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -295,11 +295,11 @@ static int bpf_testmod_test_3(void)
 static int bpf_testmod_test_4(void)
 {
 	return 0;
 }
 
-static struct bpf_testmod_ops3 __bpf_testmod_ops3 = {
+static const struct bpf_testmod_ops3 __bpf_testmod_ops3 = {
 	.test_1 = bpf_testmod_test_3,
 	.test_2 = bpf_testmod_test_4,
 };
 
 static void bpf_testmod_test_struct_ops3(void)
@@ -1273,11 +1273,11 @@ bpf_testmod_ops__test_return_ref_kptr(int dummy, struct task_struct *task__ref,
 				      struct cgroup *cgrp)
 {
 	return NULL;
 }
 
-static struct bpf_testmod_ops __bpf_testmod_ops = {
+static const struct bpf_testmod_ops __bpf_testmod_ops = {
 	.test_1 = bpf_testmod_test_1,
 	.test_2 = bpf_testmod_test_2,
 	.test_maybe_null = bpf_testmod_ops__test_maybe_null,
 	.test_refcounted = bpf_testmod_ops__test_refcounted,
 	.test_return_ref_kptr = bpf_testmod_ops__test_return_ref_kptr,
@@ -1300,11 +1300,11 @@ static int bpf_dummy_reg2(void *kdata, struct bpf_link *link)
 
 	ops->test_1();
 	return 0;
 }
 
-static struct bpf_testmod_ops2 __bpf_testmod_ops2 = {
+static const struct bpf_testmod_ops2 __bpf_testmod_ops2 = {
 	.test_1 = bpf_testmod_test_1,
 };
 
 struct bpf_struct_ops bpf_testmod_ops2 = {
 	.verifier_ops = &bpf_testmod_verifier_ops,
@@ -1547,11 +1547,11 @@ static const struct bpf_verifier_ops st_ops_verifier_ops = {
 	.gen_prologue = st_ops_gen_prologue,
 	.gen_epilogue = st_ops_gen_epilogue,
 	.get_func_proto = bpf_base_func_proto,
 };
 
-static struct bpf_testmod_st_ops st_ops_cfi_stubs = {
+static const struct bpf_testmod_st_ops st_ops_cfi_stubs = {
 	.test_prologue = bpf_test_mod_st_ops__test_prologue,
 	.test_epilogue = bpf_test_mod_st_ops__test_epilogue,
 	.test_pro_epilogue = bpf_test_mod_st_ops__test_pro_epilogue,
 };
 
@@ -1715,11 +1715,11 @@ static void multi_st_ops_unreg(void *kdata, struct bpf_link *link)
 static int bpf_testmod_multi_st_ops__test_1(struct st_ops_args *args)
 {
 	return 0;
 }
 
-static struct bpf_testmod_multi_st_ops multi_st_ops_cfi_stubs = {
+static const struct bpf_testmod_multi_st_ops multi_st_ops_cfi_stubs = {
 	.test_1 = bpf_testmod_multi_st_ops__test_1,
 };
 
 struct bpf_struct_ops testmod_multi_st_ops = {
 	.verifier_ops = &bpf_testmod_verifier_ops,
-- 
2.45.2

