Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445733;
	b=sHgWdwrGWrJBDtxVDMrB1LTUuyG3CuiA3GvkmHMgW2DivseLYErncBZfEqt3jWzMrl/f
	 7IW5BWepZU7cLhtKiHY8OjgmPNMpWYhfcKyjLi4QIjO+XJeuBTnhDCWVfRKBHdrFCcRhR
	 vkQtVpkpEx9Ugn046eDADLm/lBhACFFDYi89noZk9Hs9apzfaClwcUWz5cWLnyqHqRy6W
	 TCA0/L/qZHPQESo7gXfebhobG60qdw53E7XnSRjj9h6xd0548sQdhVqg5H+nmM54qoyad
	 QTWcaktHa5kLNeCfklOdDwheMaZ2n8dHG5Y4mzwBnlknPcwINaGE96fmFugR6Zd7Y+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KcHjG3AoFewZqdLWcVjYkH6tmmoCKyunKSeih0GE+uc=;
	b=E+S9GxtCp5bSVXAqqRgChU1kR0aw3CfvpahVzYZsM76LdK6KQYnroMnhODtlp1dqr5iF
	 cutn9mMsJ1QGhrU1mVwl0aYQZnyDbsjzRRY0Rnl/Kz64kgKFhTRCBbXDaZlPh4FpKOsrD
	 C8VrBY1x11DmxIKjRWvNNH0sTAWIgl5Rpcp12ZuaI3NxzvJVXZsItWj56/mdBKenLVJb4
	 rZwz//S2K2HqfLABkM1uEM+3oytl0gNL1tVxmpAzPlntn6WwoBHYM0bfZjQxak+1DC4EI
	 nT46p270abOFATyYziLnl/2f4AkmePQ1VpS4FbWXbrOPo55IixfFf9NhWLpeEocC5Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DXylIUWT;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF684606C1B1
	for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 14:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF684606C1B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DXylIUWT
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdb2893531bso1820395a12.1
        for <sched-ext@lists.linux.dev>; Mon, 23 Nov 2026 06:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795445732; x=1796050532; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KcHjG3AoFewZqdLWcVjYkH6tmmoCKyunKSeih0GE+uc=;
        b=DXylIUWT5v/10CPUd57HqSSD8ZfKsKGdD6yVdUqlJpLfgu5FEGucBF5974omg9cGwx
         zqwA7Bp9BcsvZLfAh0/vIQJCmCqYwrFXzi7+67Q7HQlwu5H5J1I3aNF0aqM9aQ/61u/M
         6H9xusG4cfGjoBCngq83Bcl4A9xuZzBue7gGhMzalykU1AyD4dKIqvl4wENN2PmSdtdj
         EJq6vzlVuGTWD4Bhi8F3LMs/8/UiVvj0+n8wcIZRNgNvm7m6cn3TiZKz1ORuXWN35kms
         TcHHTZ3ppwOC6dEyxSxtyrCDv8r8gmI85y0/9mkH9XxGgCz/aTytmAJmazXAAHwN00hU
         LIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445732; x=1796050532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KcHjG3AoFewZqdLWcVjYkH6tmmoCKyunKSeih0GE+uc=;
        b=wzewSYKqWgBpm197QDU8AR06fEDGunHKTXAgBYkd2HjAMVmVA8yIkPPhRt0W0/liWE
         YNDqQd+DGs1vf7pbbT1+ZSi0+SxnMsQOrDBHUG8hMTE3JuFr5otoSvRi/pRyfYVmbN5j
         3UHrTuji1cIVzth5cfpwO8B+Q8g2Q5xe9D5jL7Ro+WYZOAJFdDf3WvfANRFzmGPNIOMA
         gF/39NCW85JPANZIY+O59kvvAzuh6+kphMUQo5BTXhozOpMRB20aB6A+/YQaTASZvUgq
         cMWkcU69Bz28aMOny49oxX7qDfUPINQhp1pt08Hy/2afU4FxqOtybTJAGvbIJhXXRmjJ
         /Drg==
X-Gm-Message-State: APuU4Z804ZHq140wxKxYqsFsSXvocNbwcN3NCLUX46QkrpMRgQD7GFmB
	FxJEmi6nxQ/hjVAxhTksp0GfVqYR3VEkQX2ZUdZ9161qvZUOc75BujBmW6EaOg==
X-Gm-Gg: AZFdTZcHAWVxWEerw4cbrtyRs+uFaDijrKgBGnWwWqEM99ZiHtV6quU4GC9cCEjMtMt
	0cOkp/qeruXn0AtmZdYWITE5Fjwy7SA+xDJJF15l5J78puz67pMhrGsoJFv6UpmdNMFYlEu+cD0
	ijcpVlfBUPdfdTsPDfNOhNs2WAkfyzsZuk7SVQyD6xen2so5T+WvCLujmDmUzjKRLRl49hpokAp
	eE0QxGlsLHyzs3OFM9ET9CaW1/D84g33A5WI1EVE9F9ai1w7moROXG526tLyFfYFYyV3a2UcWS2
	I/xANcgG6iVf5IEUhyK1odIChpsJt35dWRcvPfOt//03YNCvjJ4lR2TKmkNJ71+AVn3X031uVWd
	z+IGghfk4PkC7ohF4tAOOs9+uXW5Zg2JZNxXRidDHOX+oxrp1JtmTG570ikk+zs4tHSD3Wy7o4X
	0pPPVQys/iCSLrdBNwGSPwyhdv+FQHmXGxKt/1BPedlIOGCOo0AhPPJ+faKqIpPHIoYdM7CldVh
	yOKZHu4chzh5+X95HbfUy3fAz/6WZve4ani50rfJyyHUOujjXcLoul81iKF7J/CxbOLQIXjx0xq
	5n4TihcHs6ZI8F5rtgy6nCpTR/Pq7Oqx5L5nO7l8WBTRvk+oXnyZQqrthy/XqZT/NRTspxzQa9N
	gIqDcIlevq+L+lT3E6VTrwqzfjtbKbd9G74qPjkI+RJ7HSteENGwGo64=
X-Received: by 2002:a17:90b:3f0e:b0:3b3:b6c3:ff5b with SMTP id 98e67ed59e1d1-3b41c9059e1mr10329390a91.36.1795445731883;
        Mon, 23 Nov 2026 06:55:31 -0800 (PST)
Received: from cchengyang.duckdns.org (1-164-82-37.dynamic-ip.hinet.net. [1.164.82.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfcadffsm5405516a12.9.2026.11.23.06.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:55:31 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	chengyang.chou@mediatek.com,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	stable@vger.kernel.org,
	JaeJoon Jung <rgbi3307@gmail.com>
Subject: [PATCH sched_ext/for-7.4-fixes] sched_ext: Don't request private stacks the JIT can't provide
Date: Mon, 23 Nov 2026 22:54:51 +0800
Message-ID: <20261123145450.12725-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Since commit 4f8b122848db ("sched_ext: Add basic building blocks for
nested sub-scheduler dispatching"), bpf_scx_check_member() requests a
private stack for ops.dispatch(), and later also for ops.sub_caps_updated(),
whenever CONFIG_EXT_SUB_SCHED is set, which is the default.

The verifier fails the load with -EACCES if the JIT doesn't support
private stacks, so on architectures whose JIT doesn't, like riscv64,
no BPF scheduler that implements ops.dispatch() can be loaded.

The private stack is only needed when these operations nest, which only
happens with sub-schedulers. Don't request it if the JIT can't provide
it, and refuse to attach sub-schedulers in that case. Root schedulers
then load as they did before sub-scheduler support was added.

Fixes: 4f8b122848db ("sched_ext: Add basic building blocks for nested sub-scheduler dispatching")
Cc: stable@vger.kernel.org # v7.1+
Reported-by: JaeJoon Jung <rgbi3307@gmail.com>
Link: https://lore.kernel.org/all/20260810031418.95364-1-rgbi3307@gmail.com/
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
On riscv64 in QEMU (-M virt) running for-7.4-fixes,

  # echo 1 > /proc/sys/net/core/bpf_jit_enable
  # ./scx_simple

  libbpf: prog 'simple_dispatch': BPF program load failed: -EACCES
  libbpf: prog 'simple_dispatch': -- BEGIN PROG LOAD LOG --
  Private stack not supported by jit

With it, scx_simple loads and runs.

 kernel/sched/ext/ext.c | 3 +++
 kernel/sched/ext/sub.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10de6bd865e8..3248ed57c2bb 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -9294,6 +9294,9 @@ static int bpf_scx_check_member(const struct btf_type *t,
 	 * sub-scheds and sub-scheds themselves but I don't know how to access
 	 * struct_ops from here.
 	 */
+	if (!bpf_jit_supports_private_stack())
+		return 0;
+
 	switch (moff) {
 	case offsetof(struct sched_ext_ops, dispatch):
 		prog->aux->priv_stack_requested = true;
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index d2a20114eaa2..7c069a289766 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -2246,6 +2246,12 @@ void scx_sub_enable_workfn(struct kthread_work *work)
 		goto out_unlock;
 	}
 
+	/* nesting ops need private stacks, see bpf_scx_check_member() */
+	if (!bpf_jit_supports_private_stack()) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	cgrp = cgroup_get_from_id(ops->sub_cgroup_id);
 	if (IS_ERR(cgrp)) {
 		ret = PTR_ERR(cgrp);
-- 
2.56.0

