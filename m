Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94932BDC0B
	for <sched-ext@lists.linux.dev>; Wed, 31 Dec 2025 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202647; cv=none; b=ahgmKmsoDHR4EJ63WCZwr0LeIeWEJH+bsK6XQyAeoLgLqlslEaDV7z5CeS0Cdz7O2Z3ETLW/vKziID8zTCQ0/VNEVHwdl1DaYelb/Dhivz2fJwkbmg4E6nhzApQn1aA17nvBAy2wtOmpChh6K+uUhOrHWRkchzwOX08TJ3rLHj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202647; c=relaxed/simple;
	bh=j34IflS+eKTJabK0NTs8ebKaiD8zpNvLHhM3IHbHvyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WB4GSwpGg2n+uSwh67vs1Y+7IrQrR5EV/9d3Nh5Vyq6yWIk8spR2xf4jajJHsyknf/Ah3uQ7+S/cNQakUURc7UIUIlT1Mani12GWYAIrGuD3YQ4EWXWRgLENN0MGliLKwr28xEgNSTC7uQIOD6uzQOZ4JZPIDTqV7CUDlHkeYDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Q8kQSGIc; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Q8kQSGIc"
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-63f9fa715c6so1606739d50.2
        for <sched-ext@lists.linux.dev>; Wed, 31 Dec 2025 09:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767202644; x=1767807444; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnMrXoOdHpUw8dswWZLzwCvPJsKuA+x+IPeEnhc/WiU=;
        b=Q8kQSGIc+k7vVe/O3ZTLC9T62Umo6ORhFRA8SFahnGAUuUFKDxSfZVxH12YAqceyJ3
         9jtrWERFF+rD0mD0TOQqY1h2Vf0JZ9hSpkuFe0krBKaLA8kJz2S+Heg+Yfnhf/Pvp1pm
         o92chk3ET1j2ovUU1xjnmlDeYsDI/o+vGevsFesfn3pnY7KW+jBEaMSr7VpND6u9KOiB
         yp2MwJNvTSa+UyQBrck+OjpI1uzmhAyT3UoS48+tjjvmTv3O2ujceJ5JCHOrKtukesic
         dABXqyc3P2Fyh44/o2qiFBWA/vITxUxnnKNMKypoFcebqrHJ5O6p798o1Qqr+23R20FS
         IaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202644; x=1767807444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mnMrXoOdHpUw8dswWZLzwCvPJsKuA+x+IPeEnhc/WiU=;
        b=VC3qWAhw/9IIGFjx1msQYCdXkQXYOAWOEwbPb3oo8ElfsDzmxS++S07jSKmnknqJsy
         ihZo/yPiVRpNP3XjHc6zKZUW1fvkwH8GCKoDo6JSIM5s5mngyy5szoSpqIcdkoM3Dpxz
         7kO9wtU8zNs3laE4rNgJI7tjLOck9+ps3tZvSIJpjriXLQXF2ZPVpgKaU2ec8s43bMky
         wXajuv3I+ZaR8evrsuZfD6DOrL8zxvdz1jqvbt4GaTUk+2TolBXDXeg7URcI0PVdUrBc
         b4JTDg4WHKfEx//Wg2/OQE7yNOPJdsff1yRGTZSs8MdTub7Jw9h2BtSI+8LpiWSBbegu
         eVMw==
X-Forwarded-Encrypted: i=1; AJvYcCXyehpJzdKylDsRMHGtUamSQSR1AwyvY7sKY7m+Ioe8BvECM8BqMGLBfRRvWqm6d1S4pEOUcOaeC4U=@lists.linux.dev
X-Gm-Message-State: AOJu0YxUtmaKTRjXqKL6/KiFD2uNXBu4hUoaCVCwZ47p+UynpoRSOxfZ
	XsinhWI5wLyw4KCjwSalLMAG0MDYcD/YCfGQpTFsBJHEZfFeUgqOuphICUBHJfyzI+RTRSelseB
	3SA+9Wzbe1lqod5unJC0LhHMS0iXpx5AVfpwH4nEVR1pz5lLqqzQa
X-Gm-Gg: AY/fxX5XHrsrk+vTwOb8LE22Y2dApqpyY9yvGZ5YNxBscUwZ2xWWjDU1SdsMmhpwn7X
	BJqpFZQ6Lb33DmW1mMArLqi9b0SMMUWcGIvGnOWjMD8bLncRtTrTC5X+6kUAy6QsXRUcz1YEQ7n
	E9WBf/bvitC48RDmW5X2aoIXOWQEdOOqOx3/uKt0IUolVOWeaWDxtcyUuASGvJmVdfnJUZHkC9q
	px05DMkFIMwzzuM2XfmaMskjEibXVRO+ZTWKXerMvtvycBKghbQV6uYGC+gLbV9hLay2b4K21MT
	nRxOuU9v1Pw2CxmIDWLbYmmLTB5uzimofM+if9cFTinCEv+FViGrfshZR/R9K5LdCAHTO7R9nQa
	BFP5KoKauwI61OS8izGPxRAIpq3k=
X-Google-Smtp-Source: AGHT+IFzNZ9/B42ZZcWKGBbfHMMt1MITs0v7q3q/4nZwuxereT20JgdLMhgZVahogWsIsE+x/yAB+mtzvoKa
X-Received: by 2002:a05:690e:144e:b0:644:49be:4b8e with SMTP id 956f58d0204a3-6466a7b2ee5mr25783568d50.0.1767202643860;
        Wed, 31 Dec 2025 09:37:23 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78fb4520077sm17026207b3.26.2025.12.31.09.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:37:23 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 740E834223B;
	Wed, 31 Dec 2025 10:37:22 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 6E501E4234A; Wed, 31 Dec 2025 10:37:22 -0700 (MST)
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
Subject: [PATCH 4/5] net: make cfi_stubs globals const
Date: Wed, 31 Dec 2025 10:36:32 -0700
Message-ID: <20251231173633.3981832-5-csander@purestorage.com>
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
declare the __bpf_bpf_dummy_ops, __bpf_ops_tcp_congestion_ops,
__bpf_ops_qdisc_ops, and __smc_bpf_hs_ctrl global variables it points to
as const. This allows the global variables to be placed in readonly
memory.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 net/bpf/bpf_dummy_struct_ops.c | 2 +-
 net/ipv4/bpf_tcp_ca.c          | 2 +-
 net/sched/bpf_qdisc.c          | 2 +-
 net/smc/smc_hs_bpf.c           | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 812457819b5a..198152dbce9a 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -296,11 +296,11 @@ static int bpf_dummy_test_2(struct bpf_dummy_ops_state *cb, int a1, unsigned sho
 static int bpf_dummy_test_sleepable(struct bpf_dummy_ops_state *cb)
 {
 	return 0;
 }
 
-static struct bpf_dummy_ops __bpf_bpf_dummy_ops = {
+static const struct bpf_dummy_ops __bpf_bpf_dummy_ops = {
 	.test_1 = bpf_dummy_ops__test_1,
 	.test_2 = bpf_dummy_test_2,
 	.test_sleepable = bpf_dummy_test_sleepable,
 };
 
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index e01492234b0b..bd2ce4ff1762 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -306,11 +306,11 @@ static void __bpf_tcp_ca_init(struct sock *sk)
 
 static void __bpf_tcp_ca_release(struct sock *sk)
 {
 }
 
-static struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
+static const struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
 	.ssthresh = bpf_tcp_ca_ssthresh,
 	.cong_avoid = bpf_tcp_ca_cong_avoid,
 	.set_state = bpf_tcp_ca_set_state,
 	.cwnd_event = bpf_tcp_ca_cwnd_event,
 	.in_ack_event = bpf_tcp_ca_in_ack_event,
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index adcb618a2bfc..8f9a6440f113 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -427,11 +427,11 @@ static void Qdisc_ops__reset(struct Qdisc *sch)
 
 static void Qdisc_ops__destroy(struct Qdisc *sch)
 {
 }
 
-static struct Qdisc_ops __bpf_ops_qdisc_ops = {
+static const struct Qdisc_ops __bpf_ops_qdisc_ops = {
 	.enqueue = Qdisc_ops__enqueue,
 	.dequeue = Qdisc_ops__dequeue,
 	.init = Qdisc_ops__init,
 	.reset = Qdisc_ops__reset,
 	.destroy = Qdisc_ops__destroy,
diff --git a/net/smc/smc_hs_bpf.c b/net/smc/smc_hs_bpf.c
index 063d23d85850..5c562e2a15be 100644
--- a/net/smc/smc_hs_bpf.c
+++ b/net/smc/smc_hs_bpf.c
@@ -60,11 +60,11 @@ static int __smc_bpf_stub_set_tcp_option_cond(const struct tcp_sock *tp,
 					      struct inet_request_sock *ireq)
 {
 	return 1;
 }
 
-static struct smc_hs_ctrl __smc_bpf_hs_ctrl = {
+static const struct smc_hs_ctrl __smc_bpf_hs_ctrl = {
 	.syn_option	= __smc_bpf_stub_set_tcp_option,
 	.synack_option	= __smc_bpf_stub_set_tcp_option_cond,
 };
 
 static int smc_bpf_hs_ctrl_init(struct btf *btf) { return 0; }
-- 
2.45.2

