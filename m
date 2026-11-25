Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795593762;
	b=ArLjktabE+JUJQ06GLy4X3/ofBH94ir8bcP0mruKNDrMmwWjJw+1mvRmWO0VUdcE3smA
	 +K0PHIWoALyxVCsGWvU17kRoJ2GyQ6UoZHZatYjrQZBQeiuuMjycgvtF9OPVvJlz1cjqt
	 0V/Tb5inw2jwhaNRZz8ux6lz2YGXiMFwgq0SsR5IbU4DbnH9+C4MiDVKNx1Y9hmHa4ll+
	 mqTD2cpDQxrMTdDBEaz6Wf8n8AInGznLx3TORL6NjpxIbcckXWb8xMwuick/u7JCq2Zlj
	 X1Cqxyaa7W9/tvWUalZetckW8Yl9nj/kksRsvvCPf2OODbSTYAwShWOHiDws5x30B7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=RTm26lprGFhpmR06wBJ8rVSJmCkblFzNUvHx8SA0YVE=;
	b=DudlcCxithW2dQ59PTxAcc8I0SU9o1y2z7UiczWd1SGax5sOAwiX0Lo7wNlS745UAtwv
	 /xAsIdnMGKwBpeH4z2geIBKbkfnhA1BdJdVJgZg5j301m19LkwHOq2psk2TVtwj5G88Wn
	 svAJ2U6AVCj+AFZQhcgB8AxLGPZ40xar2hyBlZ5Bud1n/WjB5RUuHvY2qgpAGSiWAmx8c
	 80dtRIgt8JhIkVmbBqWW6wISl6tG/MtXEZN3kzi+Qt4RgCAyimxtbybtMeSzbsbvNkwVS
	 GlyA1evUjLirezWOA3fAiCMaOcJoOZ3pE9qxt/+klsGjCKgrWjKDAUmiUNSn+bvczYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZupEmGss;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6051B606A321
	for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 08:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6051B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZupEmGss
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6baa6f27904so4420694a12.0
        for <sched-ext@lists.linux.dev>; Wed, 25 Nov 2026 00:02:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795593761; cv=none;
        d=google.com; s=arc-20260327;
        b=ntHZRbIWmSzwaJZpu7aRa7QiXUa2GPscyP9/GHZ9mLbKJoysyw1mUFj74HKMY1Jp4D
         4nxULHxzZia57dZsqQZNAEUtcxIwMjVIT4QZ9cTM0YS41TVEemkO8Nm12VFIKWKlATwt
         8DkqxLCDe1UuVIAVPuXAmsfrd2MRzG+5fs5O41LfcB3yppLmzxIPpAALVv6azElx2wgD
         NLWniJ/5DahcBgqDpEhF6sICH0z5d26s1OigDbsp6qhIAyrQuF1S9Yh2mKPHm7oktAZo
         xHr/nvEcdAZp+4iniZNSxphZdB6BTpLHsms/aQhmWN2p4DnCdnwKb1pd+n9y4z7S2z0X
         DnFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RTm26lprGFhpmR06wBJ8rVSJmCkblFzNUvHx8SA0YVE=;
        fh=gDinlFiGoj879BHh0+LJA/JPhBFD/AKCz8nRGZheRbQ=;
        b=if2wyiIFl4tM+M+n28oWrfesm+98fd/UMJ74pY2bx2Z4O4lwn9PjYudxt+yYItSEME
         lIaldUbJGu5Kh0CAHPP3IRO7U0fPpKQmwrXGXpMwsg530YDOHLFrInU4IEfsgOaQ8UyF
         7UCESV3wdSVTaAU5l4l1D5lWgPo1Ibqiakz8F+m/3Wu7XWtOmLCiFcdwJq/PP8PsO1Dr
         lOi62KnsVY2lySyALIhwjITmraqEsPdy9MMBxt12mil1nn9FsaPQZQKgQYTxPqhxe9WI
         VtOGXo0Q33W+Qk23AYMrzGKwPp0uaxVV78w10zOkXQP08AyRZDmFAAyiHRHKdHMka4hd
         wdGw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795593761; x=1796198561; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RTm26lprGFhpmR06wBJ8rVSJmCkblFzNUvHx8SA0YVE=;
        b=ZupEmGssnPB14P103ZzFNbGY2nOKGkviLLkOEz486Rkscu30L41i8vZ16mXEiCLR6y
         6h2oeg4M0azrL11kOB9a0Z87DeGuJ5TNUyaPuCiGNymuSjJNyB55C8lkHR3zEHomqWca
         XlO2ygK8J0Ax5V+dStppjnUUVXO3xdykWeyS3JO7Z0XzpqQNHzeeQsH+PJY4HRZz87dD
         KVzXdBYZx7FfwVt8KTS7K/EjbpD3LyDXH/bRuT2mK0PiXpzj9SlEL4KR5iYs83xxPku9
         TXwpa9qy0ybavFtn3b3OZNSCPeHWJZ4TPt4oL6vzNYqU4Hq+P1jH2q1pRoElYXJnG5wz
         6YMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795593761; x=1796198561;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RTm26lprGFhpmR06wBJ8rVSJmCkblFzNUvHx8SA0YVE=;
        b=nfxVmFdSsj/NgFq1nAYZAyM9IlusIlxwfIAE+loMw5usAGYf1y71mitumTzUcRUOao
         +MjjVKr1RxFot1TU4kVZnSGV5lEt2i7aZnJ5JJ0KoeQP+vy46gS6ljDEdvHKCHRbUDmS
         a16Ifz/p1Wued7d8So+NA0SMBpTJoel0Ia9Oq6KGYgW+yxMxwZLBOjtjEmboW+R6TtCg
         qGH7++ZHjj08XE0zEW0O5MgK7fyAzuMOfMLPcoXZ3uglgN7IKwsGdCY60972ECyUYSP0
         ZY7+7tIPCcgZA+5exdoq2Hf0NhW7Ed67eXbw+Bhe3WWmoWTsKqmxbgd5i706OUEFCsVm
         ooYQ==
X-Forwarded-Encrypted: i=1; AL+hErHQ2tV/tY+yKDIwzYZLcO3P/Tob9zwtKrSph/7epmufVjVLcvL4oBKapsbHYFLPadYfU8v80OWUY38=@lists.linux.dev
X-Gm-Message-State: APuU4Z/yTOihJZV6V29Wa8MD6RglSTr9Rw5gIO0LjZ9pvlxMlyK4amKi
	YtBjs/YwkP/yfNgZnCBWQZNita3/BVUGk8PEsyVHbmL9VxmZdwe6vTjYwhwabcy2Cg8qfovBnMQ
	TIyVplibmK+J8H69iVvi3AKI2SwzlP5gfOnBDZuA/DA==
X-Gm-Gg: AZFdTZe5lO6/Kf5hX899qBRFtxap7K+QvLBYyZWfRNrEgH2NyXNzIBdAy97hJ8N4h9T
	6SRlXCu2nivaHb1NnOIerp7sFU4Q4OlPkLya7U/lSR7GLNNjiqGNFCuHotLU2ZcQo9T6xIzLOcw
	gd8zrQVP1Ls9Qlaobbp+RUkY24ZLyScIA7/x2f+URctUd/Zq26zzmeA/nDJX/Whpa38MSi6E/vb
	OqGbL6XwPRRE4ImJhNLp1xekPKkgNLww64Od7uCLjWx7KGMT2r1JZLLM2/2V+1x/AtaqHDBC71K
	Py/jaWFsZeWkx3PG3U5sLHNdkjpXXbruA+4F1jXwI+gOtEoPpGavplMwRelZLlvhhMO4VpN5YC4
	BW+Lqmu2xCqA1JDalsl2YmcJ69QWe1juRxUwN611gIhZbUjfzlfq3Sh2o0DyU5Y3xbtq7rT5gYP
	CEQn+c8zy0cxIZ
X-Received: by 2002:a05:6402:274d:b0:6ba:92c3:fef7 with SMTP id
 4fb4d7f45d1cf-6ba92c4088cmr8311901a12.19.1795593760640; Wed, 25 Nov 2026
 00:02:40 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org> <awWc4Ca5Jj7H_kzW@scheduler.schedules>
In-Reply-To: <awWc4Ca5Jj7H_kzW@scheduler.schedules>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 25 Nov 2026 09:02:28 +0100
X-Gm-Features: Aa3M54oTNnNdEEnsQ_CBu4B0M0I3ut-loJgP53b9w3dSVKKpeAFkjaDybJeaVBE
Message-ID: <CAKfTPtDmtVv6wK46NDhm2cQkT=_gX1Rdz2dzsHT6i_hwomqjfQ@mail.gmail.com>
Subject: Re: [PATCH 00/18 v3] Improving latency of short slice tasks
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Kayra,

On Tue, 24 Nov 2026 at 18:31, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> Hi Vincent,
>
> On Fri, Nov 06, 2026 at 04:19:27PM +0100, Vincent Guittot wrote:
> > This is another round of scheduling latency improvements which fix
> > some remaining corner cases and start to fix somes cases when multi
> > short slice tasks are running simultaneously on the system.
>
> At first I wanted to just run some hackbench tests on this series.
> It was supposed to take like 10 minutes. It took me 2 days.
>
> I tried to apply it, b4 got crazy. So I tried to find the cause.
> After some little changes, I was finally able to apply the series.
>
> Then I tried to deploy the series, it didn't deploy. I thought my VM
> was going crazy. But everything was correct. Then I realised that I forgot to
> plug in my ethernet cable.
>
> Then I started gathering numbers for the base. I ran 5 tests 2 runs each.
> I thought it was finally over and I could sleep or
> start doing reviews that I was delaying.
>
> Well no. It crashed on the last test, while doing hackbench.
> I tried again, and it crashed again.
>
> My machine is a Zen 3, 8 cores 16 threads.
>
> Base: d7e670601af6c564ccf6d3b2ddf70ee4f41a6d1c
>
> Okay... Well here the logs:
>
> <4>[   73.401173] WARNING: kernel/sched/fair.c:10295 at fair_push_tasks+0x1a7/0x220, CPU#10: hackbench/1904
> <4>[   73.401182] Modules linked in:
> <4>[   73.401314] CPU: 10 UID: 0 PID: 1904 Comm: hackbench Not tainted 7.4.0-rc2+ #44 PREEMPT(lazy)
> <4>[   73.401318] Hardware name: System manufacturer System Product Name/TUF B450M-PRO GAMING, BIOS 4604 03/22/2024
> <4>[   73.401321] RIP: 0010:fair_push_tasks+0x1a7/0x220
> <4>[   73.401325] Code: c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f e9 1d cc c7 ff 0f 0b 41 0f b6 86 6d f6 ff ff 3c 01 0f 84 db fe ff ff 0f 0b e9 d4 fe ff ff <0f> 0b e9 af fe ff ff 0f 0b e9 9e fe ff ff 41 8b 84 24 e0 0f 00 00
> <4>[   73.401328] RSP: 0018:ffffd1a74b5db8c0 EFLAGS: 00010046
> <4>[   73.401332] RAX: 000000000000000a RBX: ffff8c0985518000 RCX: 0000000000000000
> <4>[   73.401335] RDX: ffff8c0c9ef1d510 RSI: ffff8c0c9ef36b60 RDI: ffff8c0c9ef36b00
> <4>[   73.401337] RBP: ffff8c0c9ef36d80 R08: 0000000000000001 R09: ffff8c0985518ff8
> <4>[   73.401340] R10: ffff8c0985518000 R11: 0000000000000000 R12: 0000000000000000
> <4>[   73.401342] R13: ffff8c0985518000 R14: ffff8c09855189c8 R15: ffff8c0c9ef36b00
> <4>[   73.401344] FS:  00007f54a42536c0(0000) GS:ffff8c0ce0f9a000(0000) knlGS:0000000000000000
> --
> <4>[   91.767339] WARNING: kernel/sched/sched.h:1722 at cpuacct_charge+0xbb/0x1a0, CPU#6: hackbench/1933
> <4>[   91.767347] Modules linked in:
> <4>[   91.767468]
> <4>[   91.767474] =============================
> <4>[   91.767476] [ BUG: Invalid wait context ]
> <4>[   91.767478] 7.4.0-rc2+ #44 Tainted: G        W
> <4>[   91.767481] -----------------------------
> <4>[   91.767483] hackbench/1929 is trying to lock:
> <4>[   91.767485] ffff8c09a59abe00 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0x3e/0x80
> <4>[   91.767496] other info that might help us debug this:
> <4>[   91.767498] context-{5:5}
> <4>[   91.767500] locks held by hackbench/1929: 3, on CPU#1:
> <4>[   91.767503]  #0: ffff8c0c95e1c460 (&pipe->mutex){+.+.}-{4:4}, at: anon_pipe_prefill_and_lock+0x123/0x210
> <4>[   91.767512]  #1: ffff8c09859d0ec0 (&p->pi_lock){-.-.}-{2:2}, at: fair_push_tasks+0xae/0x220
> <4>[   91.767521]  #2: ffff8c0c9edb6b60 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x25/0xb0
> <4>[   91.767530] stack backtrace:
> <4>[   91.767533] CPU: 1 UID: 0 PID: 1929 Comm: hackbench Tainted: G        W           7.4.0-rc2+ #44 PREEMPT(lazy)
> <4>[   91.767536] Tainted: [W]=WARN
> <4>[   91.767537] Hardware name: System manufacturer System Product Name/TUF B450M-PRO GAMING, BIOS 4604 03/22/2024
> <4>[   91.767538] Call Trace:
> <4>[   91.767539]  <TASK>
> <4>[   91.767541]  dump_stack_lvl+0x6e/0xa0
> <4>[   91.767546]  __lock_acquire+0x8d9/0xc70
> <4>[   91.767558]  lock_acquire.part.0+0x8e/0x1e0
> <4>[   91.767566]  __might_fault+0x57/0x80
> <4>[   91.767571]  _copy_from_iter+0x4e/0x770
> <4>[   91.767587]  copy_page_from_iter+0x9a/0x130
> <4>[   91.767591]  anon_pipe_write+0x524/0x7b0
> <4>[   91.767602]  vfs_write+0x424/0x580
> <4>[   91.767610]  ksys_write+0xc8/0xf0
> <4>[   91.767613]  do_syscall_64+0xed/0x1560
> <4>[   91.767628] CPU: 6 UID: 0 PID: 1933 Comm: hackbench Tainted: G        W           7.4.0-rc2+ #44 PREEMPT(lazy)
> <4>[   91.767635] Tainted: [W]=WARN
> <4>[   91.767637] Hardware name: System manufacturer System Product Name/TUF B450M-PRO GAMING, BIOS 4604 03/22/2024
> <4>[   91.767641] RIP: 0010:cpuacct_charge+0xbb/0x1a0
> <4>[   91.767647] Code: 00 00 00 48 03 04 dd 60 a1 33 bc 48 01 28 4d 8b a4 24 08 01 00 00 4d 85 e4 75 d3 48 83 c4 08 5b 5d 41 5c 41 5d e9 60 e7 c4 ff <0f> 0b eb a6 e8 ec 1b 05 00 85 c0 75 ae be ff ff ff ff 48 c7 c7 c0
> <4>[   91.767653] RSP: 0018:ffffd1a74b6c3818 EFLAGS: 00010046
> <4>[   91.767656]
> <4>[   91.767659] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> <4>[   91.767661] RDX: 0000000000000000 RSI: ffff8c0c9eab6b60 RDI: ffff8c0985940fd0
> <4>[   91.767666] RBP: 0000000000000a41 R08: 0000000000000001 R09: ffff8c0985940fd0
> <4>[   91.767670] R10: 0000003b3993930c R11: 0000000000000000 R12: ffff8c09859d0000
> <4>[   91.767674] R13: ffff8c09859d0000 R14: 0000000000000001 R15: ffff8c09859ab600
> <4>[   91.767679] FS:  00007f54a41c26c0(0000) GS:ffff8c0ce0d9a000(0000) knlGS:0000000000000000
> <4>[   91.767681] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[   91.767685] CR2: 00007febee499a78 CR3: 000000010685f000 CR4: 0000000000f50ef0
> <4>[   91.767689] PKRU: 55555554
> <4>[   91.767693] Call Trace:
> <4>[   91.767696]  <TASK>
> <4>[   91.767703]  update_se+0x167/0x2d0
> <4>[   91.767715]  update_curr+0x2b/0x190
> <4>[   91.767727]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> <4>[   91.767729]  enqueue_task_fair+0x251/0x840
> <4>[   91.767729] RIP: 0033:0x7f54a4366332
> <4>[   91.767732] Code: 08 0f 85 91 41 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 55 bf 01 00
> <4>[   91.767733] RSP: 002b:00007f54a41d5d68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> <4>[   91.767735] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f54a4366332
> <4>[   91.767736] RDX: 0000000000000064 RSI: 00007f54a41d5da0 RDI: 0000000000000022
> <4>[   91.767737] RBP: 00007f54a41d5d90 R08: 0000000000000000 R09: 0000000000000000
> <4>[   91.767738] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000064
> <4>[   91.767739] R13: 00007f54a41d5da0 R14: 000000000000000d R15: 000000003c659170
> <4>[   91.767744]  enqueue_task+0x88/0x210
> <4>[   91.767747]  </TASK>
> <1>[   91.768009] BUG: kernel NULL pointer dereference, address: 0000000000000000
> <1>[   91.768013] #PF: supervisor instruction fetch in kernel mode
> <1>[   91.768016] #PF: error_code(0x0010) - not-present page
> <6>[   91.768019] PGD 12803e067 P4D 12803e067 PUD 10acf4067 PMD 0
> <4>[   91.768026] Oops: Oops: 0010 [#1] SMP NOPTI
> <4>[   91.768029] CPU: 7 UID: 0 PID: 1929 Comm: hackbench Tainted: G        W           7.4.0-rc2+ #44 PREEMPT(lazy)
> <4>[   91.768034] Tainted: [W]=WARN
> <4>[   91.768036] Hardware name: System manufacturer System Product Name/TUF B450M-PRO GAMING, BIOS 4604 03/22/2024
> <4>[   91.768039] RIP: 0010:0x0
> <4>[   91.768045] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> <4>[   91.768048] RSP: 0018:ffffd1a74b6a3740 EFLAGS: 00010046
> <4>[   91.768052] RAX: 0000000000000001 RBX: ffff8c0c9edb6b00 RCX: ffff8c0c9edb6b48
> <4>[   91.768055] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8c0c9edb6b48
> <4>[   91.768058] RBP: ffff8c0c9edb6d80 R08: ffff8c09859d1020 R09: ffff8c09859d1020
> <4>[   91.768060] R10: ffff8c09859d0000 R11: 0000000000000000 R12: ffff8c0c9eab6b00
> <4>[   91.768062] R13: ffff8c09859d0000 R14: ffff8c09859d09c8 R15: ffff8c0c9edb6b00
> <4>[   91.768065] FS:  00007f54a41d66c0(0000) GS:ffff8c0ce0e1a000(0000) knlGS:0000000000000000
> <4>[   91.768067] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[   91.768070] CR2: ffffffffffffffd6 CR3: 000000010685f000 CR4: 0000000000f50ef0
> <4>[   91.768072] PKRU: 55555554
> <4>[   91.768074] Call Trace:
> <4>[   91.768076]  <TASK>
> <4>[   91.768372]  </TASK>
>
> Without Proxy Exec, this just disappears.

Yes, I haven't looked in detail at the impact on proxy exec which is
not enabled by default on my systems.
That will be part of the next version that I'm working on

>
>
> I just wanted to run some hackbench, I wasn't ready for doing all of this :-(.
> And I had 4 hours of sleep yesterday. I need a break on this.

sorry for the burden

>
>
> Thanks,
>
> Kayra
