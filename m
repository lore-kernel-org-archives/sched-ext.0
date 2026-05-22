Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CE435975
	for <sched-ext@lists.linux.dev>; Fri, 22 May 2026 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471039; cv=none; b=snp6v+5TKUX0diqYavdbV9jWi0xlDrHwv1tFaqkda+/x7k+ndtAztsDYsK2meIOWpwWnvw4qhoX0agUN9UXaQHtBt8EJ1u6l92zgSwjqc2l03TNrHl9Fykki6HPExU0+Za4Z6hvjYdjqpUsDpHPQ+ZofC+tMRA5UZ0C6RruXgec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471039; c=relaxed/simple;
	bh=VhBkmGmLLsybMGIXvrXKgN8VANg2tLi+JZGA4VFkBCw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MkdIPOIvEjD1vsKD/dl4Z7pnErOBFjxsMi9DiAf929fXPAU9EjyCE+iqvHZZEtig/C2U6ntHy4yP4cZTP8B+bbkzNF7TiQbnSOTPR+TEHWedOwBXmu6GGj68mfN8dpFS0t7TFZ4J2Aj7Tktsv4jWLC2PqfGa4daqzwsmzHVPnFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=bnNj8ZgC; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="bnNj8ZgC"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-3045c195251so398002eec.1
        for <sched-ext@lists.linux.dev>; Fri, 22 May 2026 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779471037; x=1780075837; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EelqnoHr5FCkbvG3Twc29L7eua8CyCTu+4+bwT3AbqE=;
        b=bnNj8ZgCREqGYcdux3SmEOep8wF0jYIxduKlsh6a7tyWGyRcelyk0BDgUn7g/feso1
         P9aMxu80h1oIxKsvENltIqUZdq+LIrdYKobc75PCaDkcjnnQyh1zgeAOL7MWTvJbJFVy
         IQ+zoSoJQkMOioUBi9JRxiyNNfFevQe7/HkJFR8yRY2fT4XPi/s7inmpWVuaSk9PQ2Pl
         KBHvombuO/WjZ5LFqI6/MiZGwlLO4eNSrWYVpPZy34+2m1m6vNR2/lrlMG8vRYxC1h4h
         1cJvcbupFdYgnSGqJX18/tpfXQMUJyjas0h3/mP4X6g0lJZsWVE8lvoj9QarsgYBSvDb
         I/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779471037; x=1780075837;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EelqnoHr5FCkbvG3Twc29L7eua8CyCTu+4+bwT3AbqE=;
        b=F/NdvkibArw8uh4fThxJtMaTrTZRsvLiOq1bq/IiWA22tXJmULnZEa8UhclKgw6yg/
         8Ke2rHPSTQtBcfKtRk4bq18+XPAdgc29jntKbLIGVwdes4FvR+mfVhJT87ddCdqSgqES
         1DmxsNE0bb0VbMVJgqMN+m4+PxpSMT/VNIptkdTj2UCkODZfXSCW5XVvtFtQbAYeag4R
         9tW8ZL5eUnX6WXWPsvcyZ08qFeBS8kTFP65UYDfyLHjT1H6+CsRRcNfGH0dnS59due3b
         e61YCSg8K//dUeQR9GfEkBzLGt6sF7pn9ZuPXS2c+yPq1vu6kdC9ndqu4uMjdzKsL6Tq
         YeuA==
X-Forwarded-Encrypted: i=1; AFNElJ++7N2nLbubHyihrcsTK9xveu/cWEsqqWRhla43VSylri498mjRoy1y1QdgQ1CsKT9CfiCSymDJRFA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6Gs1SsD7F3nKeFCv+irYgSwIix78eQ1ELv6oHbXKz1UMY0neH
	FWMTEZ5GXq9CgFq/VhteqjphTaSjS/QcSpoKG+u3ptK2e5EGV37V0CsOw0SP+vc4teg=
X-Gm-Gg: Acq92OGEu0/Q0FpX6VwN7Guy7QGPUCMyMlSc5KuHFrJXY2wpsjS3SRqMwiZptQ7uc5W
	rF8rW9aB03wUqVG1UTm5UOds6LF7lrXfA2Yo3FbTgU5DPAC6WWqWD024Ls51spio/UxYTKdt+nX
	0jC49/oNclM3PDw/ct2N6Upehkjp4P+XAxIeZxxR6WQiiv5owEqRalEoVOXPtq0FOffYvzO7OEX
	Qz4TzBLgAhzPrajrTNQw30KAyD6t13fB+YL+0NRWXhtM0igo5G1lvjvutNJ1OQozylTXVwEFt5Q
	kBwaT9IOW62u9MgFX+H/LIsSOgFiqYw4c5Krk01XQrHcMu7CsI/nPpWzJv4/TpJJ4lJ8nT9oH5H
	b+ZLm91t1a/zW7hTF7X/62fzwUcWpIgVF0/DhRFi1rekDxR4f8afXdYTegd3iMyUzNe7mSrDr+f
	gvlc2q
X-Received: by 2002:a05:7300:a10c:b0:2f2:6dde:df54 with SMTP id 5a478bee46e88-30449146a8bmr2366652eec.33.1779471036629;
        Fri, 22 May 2026 10:30:36 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::69da])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ef4719sm1445018eec.1.2026.05.22.10.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 10:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 May 2026 13:30:34 -0400
Message-Id: <DIPDU3YSFCBS.1UWA8LVD5LDE9@etsalapatis.com>
Cc: "Ching-Chun Huang" <jserv@ccns.ncku.edu.tw>, "Chia-Ping Tsai"
 <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.2 0/2] tools/sched_ext: fix scx_qmap BPF
 verifier rejection
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>, <sched-ext@lists.linux.dev>,
 "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>, "Andrea
 Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260522171406.2171819-1-yphbchou0911@gmail.com>
In-Reply-To: <20260522171406.2171819-1-yphbchou0911@gmail.com>

On Fri May 22, 2026 at 1:13 PM EDT, Cheng-Yang Chou wrote:
> scx_qmap fails to load with modern LLVM due to LLVM liveness killing the
> PTR_TO_ARENA register alias before arena stores. The BPF verifier rejects
> these stores with "RN invalid mem access 'scalar'".
>
> Patch 1: moves bpf_addr_space_cast() before the #if block so it is always
> available regardless of LLVM version.
>
> Patch 2: calls bpf_addr_space_cast() at every arena store site in scx_qma=
p
> where the PTR_TO_ARENA alias dies before the write.
>
> Failure observed on sched_ext/for-next with vng (without this series):

I do not think this is the way to go about this problem. Annotations,
especially heavily BPF-specific like this, are too obscure for us to
expect people to use. If anything this seems like something we should
handle in the verifier.

Can you elaborate on "LLVM liveness killing the register alias"? This
seems like missing addr_space_cast() instructions added by the compiler,
for some reason it tries to use r7 directly instead of either reusing or
rebuilding r8. Also, which Clang version are you using?

>
> root@virtme-ng:/home/ubuntu/sched_ext/tools/sched_ext# ./build/bin/scx_qm=
ap
> libbpf: prog 'qmap_dequeue': BPF program load failed: -EACCES
> libbpf: prog 'qmap_dequeue': -- BEGIN PROG LOAD LOG --
> 0: R1=3Dctx() R10=3Dfp0
> ; void BPF_STRUCT_OPS(qmap_dequeue, struct task_struct *p, u64 deq_flags)=
 @ scx_qmap.bpf.c:467
> 0: (79) r2 =3D *(u64 *)(r1 +0)
> func 'dequeue' arg0 has btf_id 115922 type STRUCT 'task_struct'
> 1: R1=3Dctx() R2=3Dtrusted_ptr_task_struct()
> 1: (79) r4 =3D *(u64 *)(r1 +8)          ; R1=3Dctx() R4=3Dscalar()
> ; __sync_fetch_and_add(&qa.nr_dequeued, 1); @ scx_qmap.bpf.c:471
> 2: (18) r1 =3D 0x10000fff9000           ; R1=3Dscalar()
> 4: (18) r3 =3D 0x10000fff9000           ; R3=3Dscalar()
> 6: (07) r3 +=3D 32                      ; R3=3Dscalar()
> 7: (bf) r5 =3D addr_space_cast(r3, 0, 1)        ; R3=3Dscalar() R5=3Daren=
a
> 8: (b7) r3 =3D 1                        ; R3=3D1
> 9: (b7) r0 =3D 1                        ; R0=3D1
> 10: (db) r0 =3D atomic64_fetch_add((u64 *)(r5 +0), r0)          ; R0=3Dsc=
alar() R5=3Darena
> 11: (18) r5 =3D 0x100000000             ; R5=3D0x100000000
> ; if (deq_flags & SCX_DEQ_CORE_SCHED_EXEC) @ scx_qmap.bpf.c:472
> 13: (5f) r4 &=3D r5                     ; R4=3Dscalar(smin=3Dsmin32=3D0,s=
max=3Dumax=3D0x100000000,smax32=3Dumax32=3D0,var_off=3D(0x0; 0x100000000))
> 14: (15) if r4 =3D=3D 0x0 goto pc+3       ; R4=3D0x100000000
> ; __sync_fetch_and_add(&qa.nr_core_sched_execed, 1); @ scx_qmap.bpf.c:473
> 15: (07) r1 +=3D 48                     ; R1=3Dscalar()
> 16: (bf) r1 =3D addr_space_cast(r1, 0, 1)       ; R1=3Darena
> 17: (db) r3 =3D atomic64_fetch_add((u64 *)(r1 +0), r3)          ;
> ; QMAP_TOUCH_ARENA(); @ scx_qmap.bpf.c:247
> 18: (18) r1 =3D 0xff110001062b6800      ; R1=3Dmap_ptr(map=3Darena,ks=3D0=
,vs=3D0)
> ; v =3D bpf_task_storage_get(&task_ctx_stor, p, 0, 0); @ scx_qmap.bpf.c:2=
49
> 20: (18) r1 =3D 0xff11000105cafc00      ; R1=3Dmap_ptr(map=3Dtask_ctx_sto=
r,ks=3D4,vs=3D8)
> 22: (b7) r3 =3D 0                       ; R3=3D0
> 23: (b7) r4 =3D 0                       ; R4=3D0
> 24: (85) call bpf_task_storage_get#156        ; R0=3Dmap_value_or_null(id=
=3D1,map=3Dtask_ctx_stor,ks=3D4,vs=3D8)
> ; if (!v || !v->taskc) @ scx_qmap.bpf.c:250
> 25: (15) if r0 =3D=3D 0x0 goto pc+77      ; R0=3Dmap_value(map=3Dtask_ctx=
_stor,ks=3D4,vs=3D8)
> 26: (79) r7 =3D *(u64 *)(r0 +0)         ; R0=3Dmap_value(map=3Dtask_ctx_s=
tor,ks=3D4,vs=3D8) R7=3Dscalar()
> 27: (15) if r7 =3D=3D 0x0 goto pc+75      ; R7=3Dscalar(umin=3D1)
> 28: (bf) r8 =3D addr_space_cast(r7, 0, 1)       ; R7=3Dscalar(umin=3D1) R=
8=3Darena
> ; if (taskc && taskc->fifo) { @ scx_qmap.bpf.c:476
> 29: (79) r9 =3D *(u64 *)(r8 +24)        ; R8=3Darena R9=3Dscalar()
> 30: (15) if r9 =3D=3D 0x0 goto pc+72      ; R9=3Dscalar(umin=3D1)
> ; if (taskc->highpri) @ scx_qmap.bpf.c:477
> 31: (71) r1 =3D *(u8 *)(r8 +45)         ; R1=3Dscalar(smin=3Dsmin32=3D0,s=
max=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=3D(0x0; 0xff)) R8=3Darena
> 32: (56) if w1 !=3D 0x1 goto pc+9       ; R1=3D1
> 33: (b7) r1 =3D 1                       ; R1=3D1
> ; __sync_fetch_and_sub(&qa.nr_highpri_queued, 1); @ scx_qmap.bpf.c:478
> 34: (87) r1 =3D -r1                     ; R1=3D-1
> 35: (18) r2 =3D 0x10000fff9000          ; R2=3Dscalar()
> 37: (07) r2 +=3D 88                     ; R2=3Dscalar()
> 38: (bf) r2 =3D addr_space_cast(r2, 0, 1)       ; R2=3Darena
> 39: (db) r1 =3D atomic64_fetch_add((u64 *)(r2 +0), r1)          ; R1=3Dsc=
alar() R2=3Darena
> ; struct qmap_fifo __arena *fifo =3D taskc->fifo; @ scx_qmap.bpf.c:299
> 40: (79) r9 =3D *(u64 *)(r8 +24)        ; R8=3Darena R9=3Dscalar()
> ; if (!fifo) @ scx_qmap.bpf.c:302
> 41: (15) if r9 =3D=3D 0x0 goto pc+61      ; R9=3Dscalar(umin=3D1)
> ; lock =3D qa_q_lock(fifo->idx); @ scx_qmap.bpf.c:305
> 42: (bf) r2 =3D addr_space_cast(r9, 0, 1)       ; R2=3Darena R9=3Dscalar(=
umin=3D1)
> 43: (61) r1 =3D *(u32 *)(r2 +16)        ; R1=3Dscalar(smin=3D0,smax=3Duma=
x=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R2=3Darena
> ; switch (qid) { @ scx_qmap.bpf.c:110
> 44: (66) if w1 s> 0x1 goto pc+8       ; R1=3Dscalar(smin=3D0,smax=3Dumax=
=3D0xffffffff,smax32=3D1,var_off=3D(0x0; 0xffffffff))
> 45: (18) r6 =3D 0xff11000105caf1e8      ; R6=3Dmap_value(map=3D.data.qa_q=
_lock,ks=3D4,vs=3D4)
> 47: (16) if w1 =3D=3D 0x0 goto pc+17      ; R1=3Dscalar(smin=3Dumin=3Dumi=
n32=3D1,smax=3Dumax=3D0xffffffff,smax32=3D1,var_off=3D(0x0; 0xffffffff))
> 48: (16) if w1 =3D=3D 0x1 goto pc+1 50: R2=3Darena R7=3Dscalar(umin=3D1) =
R8=3Darena R9=3Dscalar(umin=3D1) R10=3Dfp0
> ; switch (qid) { @ scx_qmap.bpf.c:110
> 50: (18) r6 =3D 0xff11000105caede8      ; R6=3Dmap_value(map=3D.data.qa_q=
_lock,ks=3D4,vs=3D4)
> 52: (05) goto pc+12
> 65: (7b) *(u64 *)(r10 -16) =3D r2       ; R2=3Darena R10=3Dfp0 fp-16=3Dar=
ena
> ; if (bpf_res_spin_lock(lock)) { @ scx_qmap.bpf.c:193
> 66: (bf) r1 =3D r6                      ; R1=3Dmap_value(map=3D.data.qa_q=
_lock,ks=3D4,vs=3D4) R6=3Dmap_value(map=3D.data.qa_q_lock,ks=3D4,vs=3D4)
> 67: (85) call bpf_res_spin_lock#69027         ; R0=3D0
> 68: (16) if w0 =3D=3D 0x0 goto pc+9       ; R0=3D0
> ; if (taskc->fifo !=3D fifo) { @ scx_qmap.bpf.c:310
> 78: (79) r1 =3D *(u64 *)(r8 +24)        ; R1=3Dscalar() R8=3Darena
> 79: (1d) if r1 =3D=3D r9 goto pc+1 81: R6=3Dmap_value(map=3D.data.qa_q_lo=
ck,ks=3D4,vs=3D4) R7=3Dscalar(umin=3D1) R8=3Darena R10=3Dfp0 fp-16=3Darena
> ; bpf_res_spin_unlock(lock); @ scx_qmap.bpf.c:311
> 81: (79) r2 =3D *(u64 *)(r8 +16)        ; R2=3Dscalar() R8=3Darena
> ; if (taskc->q_next) @ scx_qmap.bpf.c:315
> 82: (79) r1 =3D *(u64 *)(r8 +8)         ; R1=3Dscalar() R8=3Darena
> 83: (15) if r1 =3D=3D 0x0 goto pc+4       ; R1=3Dscalar(umin=3D1)
> 84: (bf) r3 =3D addr_space_cast(r1, 0, 1)       ; R1=3Dscalar(umin=3D1) R=
3=3Darena
> ; taskc->q_next->q_prev =3D taskc->q_prev; @ scx_qmap.bpf.c:316
> 85: (7b) *(u64 *)(r3 +16) =3D r2        ; R2=3Dscalar() R3=3Darena
> ; if (taskc->q_prev) @ scx_qmap.bpf.c:319
> 86: (79) r2 =3D *(u64 *)(r8 +16)        ; R2=3Dscalar() R8=3Darena
> ; taskc->q_next->q_prev =3D taskc->q_prev; @ scx_qmap.bpf.c:316
> 87: (05) goto pc+2
> ; fifo->tail =3D taskc->q_prev; @ scx_qmap.bpf.c:318
> 90: (07) r7 +=3D 8                      ; R7=3Dscalar()
> ; if (taskc->q_prev) @ scx_qmap.bpf.c:319
> 91: (15) if r2 =3D=3D 0x0 goto pc+3       ; R2=3Dscalar(umin=3D1)
> 92: (bf) r2 =3D addr_space_cast(r2, 0, 1)       ; R2=3Darena
> ; taskc->q_prev->q_next =3D taskc->q_next; @ scx_qmap.bpf.c:320
> 93: (7b) *(u64 *)(r2 +8) =3D r1         ; R1=3Dscalar(umin=3D1) R2=3Daren=
a
> 94: (05) goto pc+2
> ; fifo->head =3D taskc->q_next; @ scx_qmap.bpf.c:322
> 97: (b7) r1 =3D 0                       ; R1=3D0
> ; taskc->q_prev =3D NULL; @ scx_qmap.bpf.c:324
> 98: (7b) *(u64 *)(r7 +16) =3D r1
> R7 invalid mem access 'scalar'
> processed 70 insns (limit 1000000) max_states_per_insn 1 total_states 5 p=
eak_states 5 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'qmap_dequeue': failed to load: -EACCES
> libbpf: failed to load object 'scx_qmap'
> libbpf: failed to load BPF skeleton 'scx_qmap': -EACCES
> [SCX_BUG] scx_qmap.c:193 (Permission denied)
> Failed to load skel
>
> Thanks,
> Cheng-Yang
>
> ---
>
> Cheng-Yang Chou (2):
>   tools/sched_ext: always define bpf_addr_space_cast
>   tools/sched_ext: scx_qmap: fix arena stores
>
>  .../include/scx/bpf_arena_common.bpf.h        | 21 +++--
>  tools/sched_ext/scx_qmap.bpf.c                | 85 +++++++++++++------
>  2 files changed, 71 insertions(+), 35 deletions(-)
>
> --
> 2.48.1

