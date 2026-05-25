Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519063B52E6
	for <sched-ext@lists.linux.dev>; Mon, 25 May 2026 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779718586; cv=none; b=VVjiNL9WCnh4FvfbNqHbW2Zu+JMrA2dVHT52MgjPP0C4je2m+c1kuUAObjSZQgxjtWG5ueLI6TQhOsZO28DNk8FvIUGmPm9cMmwP/lqnFZKd3rwKQfeOaGSEYIT/uzWNmZtcUkR0u3WbGumFz6GYceZtN99BzDeyVs+7MMYTRSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779718586; c=relaxed/simple;
	bh=Na984A6RF1vcnaXIh6MaJfclzAdKIe0jqXX2ZN+E0as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSVPjlfL4bZeVTqKYSeg8Ml716cCFyNnpDP20yUMv4YNdVBkIRNKcEXvEH51JefPu/oGSVWYZu5130YbfZyXbx41fWxw1d1r0ZloyAfGSVU/yEX5JCPyZ9ugXiqbMoZc4oI6mCi+wFR2cicdx52+9bS7mSmQ+rUV9+8F8lynGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUrB5Txg; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUrB5Txg"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3698e34a567so8856522a91.2
        for <sched-ext@lists.linux.dev>; Mon, 25 May 2026 07:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779718581; x=1780323381; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r7SNoBfpX3xCN0HambARIFrZeNvOXU+9QXICYeAYzkY=;
        b=gUrB5TxgxK2CvhboB/K2/pcL/9zdwKctW6fDzybHGH5fLoENpAxvZ6+TAZxqIQkIBV
         p5+KKwCPe5tOhvWDnk81qoKMXwUwHP0R8RiJq5hMz61MqsMhYpJciM66KAhlO0roaheS
         4mlLt3+o9cXIXUGvFMHh5DU6jQpm0ZEvunImuRuX1w8cv+n7OK3P+6waTzVKtIFUvYFD
         Pxd1C3nZHC/IVNQlVCoOgBa8kXsbiK1g4o5iDtQkt8GIeUYT5C8S7TxUlQRG/8sTfbB2
         1AEtvoSNIEQshnvwQ0nF4psz4XKqQWoUrEKITFyqbrBEqEAqmzoXj9HKJ+e/J71EuJRW
         pqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779718581; x=1780323381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7SNoBfpX3xCN0HambARIFrZeNvOXU+9QXICYeAYzkY=;
        b=DBe21skr/pzcymok6reIFpvAd/S4DA6sBKmQY/OCuqBUE4OpgdAVUh+uie3n9F9DDo
         GgqyGIn1B63zARZbwWW5STLxXzbvUFvEg80Medq3tWgHYN3hnyUOTJNkQ95ezSnEEmfK
         ZXi/swdfdtKgw5hudaSdw0mLXghFRg1IRcRVZJh/lJrnK2I4Q3FJ2ipABo0jwOGaRZDQ
         2J0Q63ag+JndZYDI/IaoL6IzQo2WSXNRq0xvzSHZmNZsBIkt3GTUN0qSJZLLWnSluDdg
         3lbyJFSHeF/de3dBD1ODIoEJEioCuedApPLViO4O50bNnx/l5cbFC5VPGzOt/krmbwax
         iv8g==
X-Gm-Message-State: AOJu0YxY1gIlYrn1J+P8NqQ0gEVMWd6S+pvLTX83t1RjXBnknMJb5rCV
	vxs8FTkzvWIokFLWi3kj+EoJMILBrFRXANF7+Qi1RXY3Gj/GD/zRZeZz
X-Gm-Gg: Acq92OErgE6DiuRgSnLqfAaPrFEdytEt9eNT5aqWC7ZPj8827Jg0LP7XBBC3/PqZyNO
	GclyCZGdUHHvh5P4efvwMcAHyUQ9tzxZw1iemgRcQytpXFLtYWj0uqQtgb92swqIr2IacEfUmYM
	iCgZJYWBbJ7IsoYpVnUQhCz2/4PGn8bKBC/mG/3I1stIjDSIsOlFZSOxFgdWeUZPGr75CuP13/9
	8zx0Iee9EQfke6qzs33u08ZBIiILWTlWhrRNmZmxyDlWgTvODkRpP0T++CRFPuNswK5L/UWT3pt
	7+9wLXILYoZm3O/3ZQVg8NMKluJ0ZNKgQbSpljG5FlTmB8ka8pI2Lz7ussUlSEKl3A9HQjTR1wT
	C+9XQDotB3V0UDCVwFKFfWWJnC2M/2yHlWwaGtBnZSYZgRIIv4mjhxeN8Q/I6QyL+qLWtE2lL7N
	bxHj9bj5tTsWqubtCPhM738Mh5Dimm3H7zg8xPheujYL9Vr5Mz537L2BCCTG1DsU1dQpZ858BTc
	r7ixJC+EqeihgiyCxc=
X-Received: by 2002:a17:90b:48c1:b0:35f:c729:de9b with SMTP id 98e67ed59e1d1-36a677f44b2mr15561120a91.20.1779718581183;
        Mon, 25 May 2026 07:16:21 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-109-223.dynamic-ip.hinet.net. [36.225.109.223])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a71dbeec4sm10304907a91.6.2026.05.25.07.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 07:16:20 -0700 (PDT)
Date: Mon, 25 May 2026 22:16:16 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.2 0/2] tools/sched_ext: fix scx_qmap BPF
 verifier rejection
Message-ID: <20260525221229.G1dad@cchengyang.duckdns.org>
References: <20260522171406.2171819-1-yphbchou0911@gmail.com>
 <DIPDU3YSFCBS.1UWA8LVD5LDE9@etsalapatis.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIPDU3YSFCBS.1UWA8LVD5LDE9@etsalapatis.com>

Hi Emil,

On Fri, May 22, 2026 at 01:30:34PM -0400, Emil Tsalapatis wrote:
> On Fri May 22, 2026 at 1:13 PM EDT, Cheng-Yang Chou wrote:
> > scx_qmap fails to load with modern LLVM due to LLVM liveness killing the
> > PTR_TO_ARENA register alias before arena stores. The BPF verifier rejects
> > these stores with "RN invalid mem access 'scalar'".
> >
> > Patch 1: moves bpf_addr_space_cast() before the #if block so it is always
> > available regardless of LLVM version.
> >
> > Patch 2: calls bpf_addr_space_cast() at every arena store site in scx_qmap
> > where the PTR_TO_ARENA alias dies before the write.
> >
> > Failure observed on sched_ext/for-next with vng (without this series):
> 
> I do not think this is the way to go about this problem. Annotations,
> especially heavily BPF-specific like this, are too obscure for us to
> expect people to use. If anything this seems like something we should
> handle in the verifier.

Agreed.

> 
> Can you elaborate on "LLVM liveness killing the register alias"? This
> seems like missing addr_space_cast() instructions added by the compiler,
> for some reason it tries to use r7 directly instead of either reusing or
> rebuilding r8.

Liveness analysis marks r8 dead after insn 86. When generating the
stores at insn 98, LLVM uses r7 without re-emitting addr_space_cast.
From the IR perspective the store target is the same pointer. IIUC,
LLVM relies on the address-space annotation on the type rather than
on the register alias, so no second cast is emitted. The BPF backend
translates that to a scalar store, which the verifier rejects.
  
	26: (79) r7 = *(u64 *)(r0 +0)            ; R7=scalar()
	28: (bf) r8 = addr_space_cast(r7, 0, 1)  ; R7=scalar(umin=1) R8=arena
	...
	86: (79) r2 = *(u64 *)(r8 +16)           ; R8=arena  <- last use of r8
	... 
	90: (07) r7 += 8                         ; R7=scalar <- r8 dead, LLVM uses r7
	...
	98: (7b) *(u64 *)(r7 +16) = r1
	R7 invalid mem access 'scalar'

> Also, which Clang version are you using?

$ clang --version
Ubuntu clang version 20.1.2 (0ubuntu1)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/lib/llvm-20/bin

Thanks.

> >
> > root@virtme-ng:/home/ubuntu/sched_ext/tools/sched_ext# ./build/bin/scx_qmap
> > libbpf: prog 'qmap_dequeue': BPF program load failed: -EACCES
> > libbpf: prog 'qmap_dequeue': -- BEGIN PROG LOAD LOG --
> > 0: R1=ctx() R10=fp0
> > ; void BPF_STRUCT_OPS(qmap_dequeue, struct task_struct *p, u64 deq_flags) @ scx_qmap.bpf.c:467
> > 0: (79) r2 = *(u64 *)(r1 +0)
> > func 'dequeue' arg0 has btf_id 115922 type STRUCT 'task_struct'
> > 1: R1=ctx() R2=trusted_ptr_task_struct()
> > 1: (79) r4 = *(u64 *)(r1 +8)          ; R1=ctx() R4=scalar()
> > ; __sync_fetch_and_add(&qa.nr_dequeued, 1); @ scx_qmap.bpf.c:471
> > 2: (18) r1 = 0x10000fff9000           ; R1=scalar()
> > 4: (18) r3 = 0x10000fff9000           ; R3=scalar()
> > 6: (07) r3 += 32                      ; R3=scalar()
> > 7: (bf) r5 = addr_space_cast(r3, 0, 1)        ; R3=scalar() R5=arena
> > 8: (b7) r3 = 1                        ; R3=1
> > 9: (b7) r0 = 1                        ; R0=1
> > 10: (db) r0 = atomic64_fetch_add((u64 *)(r5 +0), r0)          ; R0=scalar() R5=arena
> > 11: (18) r5 = 0x100000000             ; R5=0x100000000
> > ; if (deq_flags & SCX_DEQ_CORE_SCHED_EXEC) @ scx_qmap.bpf.c:472
> > 13: (5f) r4 &= r5                     ; R4=scalar(smin=smin32=0,smax=umax=0x100000000,smax32=umax32=0,var_off=(0x0; 0x100000000))
> > 14: (15) if r4 == 0x0 goto pc+3       ; R4=0x100000000
> > ; __sync_fetch_and_add(&qa.nr_core_sched_execed, 1); @ scx_qmap.bpf.c:473
> > 15: (07) r1 += 48                     ; R1=scalar()
> > 16: (bf) r1 = addr_space_cast(r1, 0, 1)       ; R1=arena
> > 17: (db) r3 = atomic64_fetch_add((u64 *)(r1 +0), r3)          ;
> > ; QMAP_TOUCH_ARENA(); @ scx_qmap.bpf.c:247
> > 18: (18) r1 = 0xff110001062b6800      ; R1=map_ptr(map=arena,ks=0,vs=0)
> > ; v = bpf_task_storage_get(&task_ctx_stor, p, 0, 0); @ scx_qmap.bpf.c:249
> > 20: (18) r1 = 0xff11000105cafc00      ; R1=map_ptr(map=task_ctx_stor,ks=4,vs=8)
> > 22: (b7) r3 = 0                       ; R3=0
> > 23: (b7) r4 = 0                       ; R4=0
> > 24: (85) call bpf_task_storage_get#156        ; R0=map_value_or_null(id=1,map=task_ctx_stor,ks=4,vs=8)
> > ; if (!v || !v->taskc) @ scx_qmap.bpf.c:250
> > 25: (15) if r0 == 0x0 goto pc+77      ; R0=map_value(map=task_ctx_stor,ks=4,vs=8)
> > 26: (79) r7 = *(u64 *)(r0 +0)         ; R0=map_value(map=task_ctx_stor,ks=4,vs=8) R7=scalar()
> > 27: (15) if r7 == 0x0 goto pc+75      ; R7=scalar(umin=1)
> > 28: (bf) r8 = addr_space_cast(r7, 0, 1)       ; R7=scalar(umin=1) R8=arena
> > ; if (taskc && taskc->fifo) { @ scx_qmap.bpf.c:476
> > 29: (79) r9 = *(u64 *)(r8 +24)        ; R8=arena R9=scalar()
> > 30: (15) if r9 == 0x0 goto pc+72      ; R9=scalar(umin=1)
> > ; if (taskc->highpri) @ scx_qmap.bpf.c:477
> > 31: (71) r1 = *(u8 *)(r8 +45)         ; R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff)) R8=arena
> > 32: (56) if w1 != 0x1 goto pc+9       ; R1=1
> > 33: (b7) r1 = 1                       ; R1=1
> > ; __sync_fetch_and_sub(&qa.nr_highpri_queued, 1); @ scx_qmap.bpf.c:478
> > 34: (87) r1 = -r1                     ; R1=-1
> > 35: (18) r2 = 0x10000fff9000          ; R2=scalar()
> > 37: (07) r2 += 88                     ; R2=scalar()
> > 38: (bf) r2 = addr_space_cast(r2, 0, 1)       ; R2=arena
> > 39: (db) r1 = atomic64_fetch_add((u64 *)(r2 +0), r1)          ; R1=scalar() R2=arena
> > ; struct qmap_fifo __arena *fifo = taskc->fifo; @ scx_qmap.bpf.c:299
> > 40: (79) r9 = *(u64 *)(r8 +24)        ; R8=arena R9=scalar()
> > ; if (!fifo) @ scx_qmap.bpf.c:302
> > 41: (15) if r9 == 0x0 goto pc+61      ; R9=scalar(umin=1)
> > ; lock = qa_q_lock(fifo->idx); @ scx_qmap.bpf.c:305
> > 42: (bf) r2 = addr_space_cast(r9, 0, 1)       ; R2=arena R9=scalar(umin=1)
> > 43: (61) r1 = *(u32 *)(r2 +16)        ; R1=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R2=arena
> > ; switch (qid) { @ scx_qmap.bpf.c:110
> > 44: (66) if w1 s> 0x1 goto pc+8       ; R1=scalar(smin=0,smax=umax=0xffffffff,smax32=1,var_off=(0x0; 0xffffffff))
> > 45: (18) r6 = 0xff11000105caf1e8      ; R6=map_value(map=.data.qa_q_lock,ks=4,vs=4)
> > 47: (16) if w1 == 0x0 goto pc+17      ; R1=scalar(smin=umin=umin32=1,smax=umax=0xffffffff,smax32=1,var_off=(0x0; 0xffffffff))
> > 48: (16) if w1 == 0x1 goto pc+1 50: R2=arena R7=scalar(umin=1) R8=arena R9=scalar(umin=1) R10=fp0
> > ; switch (qid) { @ scx_qmap.bpf.c:110
> > 50: (18) r6 = 0xff11000105caede8      ; R6=map_value(map=.data.qa_q_lock,ks=4,vs=4)
> > 52: (05) goto pc+12
> > 65: (7b) *(u64 *)(r10 -16) = r2       ; R2=arena R10=fp0 fp-16=arena
> > ; if (bpf_res_spin_lock(lock)) { @ scx_qmap.bpf.c:193
> > 66: (bf) r1 = r6                      ; R1=map_value(map=.data.qa_q_lock,ks=4,vs=4) R6=map_value(map=.data.qa_q_lock,ks=4,vs=4)
> > 67: (85) call bpf_res_spin_lock#69027         ; R0=0
> > 68: (16) if w0 == 0x0 goto pc+9       ; R0=0
> > ; if (taskc->fifo != fifo) { @ scx_qmap.bpf.c:310
> > 78: (79) r1 = *(u64 *)(r8 +24)        ; R1=scalar() R8=arena
> > 79: (1d) if r1 == r9 goto pc+1 81: R6=map_value(map=.data.qa_q_lock,ks=4,vs=4) R7=scalar(umin=1) R8=arena R10=fp0 fp-16=arena
> > ; bpf_res_spin_unlock(lock); @ scx_qmap.bpf.c:311
> > 81: (79) r2 = *(u64 *)(r8 +16)        ; R2=scalar() R8=arena
> > ; if (taskc->q_next) @ scx_qmap.bpf.c:315
> > 82: (79) r1 = *(u64 *)(r8 +8)         ; R1=scalar() R8=arena
> > 83: (15) if r1 == 0x0 goto pc+4       ; R1=scalar(umin=1)
> > 84: (bf) r3 = addr_space_cast(r1, 0, 1)       ; R1=scalar(umin=1) R3=arena
> > ; taskc->q_next->q_prev = taskc->q_prev; @ scx_qmap.bpf.c:316
> > 85: (7b) *(u64 *)(r3 +16) = r2        ; R2=scalar() R3=arena
> > ; if (taskc->q_prev) @ scx_qmap.bpf.c:319
> > 86: (79) r2 = *(u64 *)(r8 +16)        ; R2=scalar() R8=arena
> > ; taskc->q_next->q_prev = taskc->q_prev; @ scx_qmap.bpf.c:316
> > 87: (05) goto pc+2
> > ; fifo->tail = taskc->q_prev; @ scx_qmap.bpf.c:318
> > 90: (07) r7 += 8                      ; R7=scalar()
> > ; if (taskc->q_prev) @ scx_qmap.bpf.c:319
> > 91: (15) if r2 == 0x0 goto pc+3       ; R2=scalar(umin=1)
> > 92: (bf) r2 = addr_space_cast(r2, 0, 1)       ; R2=arena
> > ; taskc->q_prev->q_next = taskc->q_next; @ scx_qmap.bpf.c:320
> > 93: (7b) *(u64 *)(r2 +8) = r1         ; R1=scalar(umin=1) R2=arena
> > 94: (05) goto pc+2
> > ; fifo->head = taskc->q_next; @ scx_qmap.bpf.c:322
> > 97: (b7) r1 = 0                       ; R1=0
> > ; taskc->q_prev = NULL; @ scx_qmap.bpf.c:324
> > 98: (7b) *(u64 *)(r7 +16) = r1
> > R7 invalid mem access 'scalar'
> > processed 70 insns (limit 1000000) max_states_per_insn 1 total_states 5 peak_states 5 mark_read 0
> > -- END PROG LOAD LOG --
> > libbpf: prog 'qmap_dequeue': failed to load: -EACCES
> > libbpf: failed to load object 'scx_qmap'
> > libbpf: failed to load BPF skeleton 'scx_qmap': -EACCES
> > [SCX_BUG] scx_qmap.c:193 (Permission denied)
> > Failed to load skel
> >
> > Thanks,
> > Cheng-Yang
> >
> > ---
> >
> > Cheng-Yang Chou (2):
> >   tools/sched_ext: always define bpf_addr_space_cast
> >   tools/sched_ext: scx_qmap: fix arena stores
> >
> >  .../include/scx/bpf_arena_common.bpf.h        | 21 +++--
> >  tools/sched_ext/scx_qmap.bpf.c                | 85 +++++++++++++------
> >  2 files changed, 71 insertions(+), 35 deletions(-)
> >
> > --
> > 2.48.1
> 

-- 
Cheers,
Cheng-Yang
