Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1523815E2
	for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776663006; cv=none; b=K6qOvrvrLsJiL1PwfR0C2F+sFAa6OJWzHkuQdST7FD2tYaFfTabHO+LZDwdHMBTOQZmPQP6j5t4n/TmSLvpLrcC9XjDtsoEoMHhP3aXEkvGmgEkVF3tuV3q+o6grG0BuR8fDIZLKp3reVwQkw6KT1WsQxyJQ7Xntk9u9xE9Ggqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776663006; c=relaxed/simple;
	bh=aEamj7vHP2uw8wPCnBhcwTLKt2YwF8jj2+rbh7f78TM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dl8UjnH4UrxDAH2kwaIVj89830664ZQt7PMT81Xp+yBXSEli0N6fNZrEBn04Awokhc7Zsr3oy1He953GEwQa/LlvLDcpMo3+Qru4VSNZTwZOsJwNeb++oJqfzbPacGyEhwfM9E0S0eaC90bXmQdFB4lqw5rO9Dh7wFsPrKTxhDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4AKwjSH; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4AKwjSH"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c7973bbc16dso1742791a12.0
        for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 22:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776663004; x=1777267804; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvh9TKyLrQhY1Uk5M4VD8G31WO9314O9D/VYgtBuUHo=;
        b=I4AKwjSH4Lo3l6dR1nZSIDABEG8pCR6hY2WPeNbRt9sAoWrcje7fISS+DkSp9obGux
         QLd420p9v7PNMumyz1KoxRSYJVyqJ7yb8MIT6ytQC8eWWlNULKcWRhLFCjM8ZgX397qB
         kle7NTjHtoE4qjGkjTOGoCkClTwia2qS+p7+nj4aoVGawFIwt2LeV7jKJ5Rc8Khw4lU6
         ygRyPfNk0pcl6VY9n+O9gkcqcL7GeBiuiG0G+lF1P1EGsCaS66qwQfVXAz9FDrDwAD1u
         mgzwiMSI48nW5deOouooZI7U3PY9JTmt3qG3H2u8IZ1mitLquICmDGOfevNAUB///PCh
         Qk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776663004; x=1777267804;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rvh9TKyLrQhY1Uk5M4VD8G31WO9314O9D/VYgtBuUHo=;
        b=pHTRXaO0/u9NRSqqnJ6qEOdAJsvIUXI+rvQmeZl/vCm62FS5lI5L2vtmmpdo6WRY3G
         +8VodFQ9dck2x4EXMklKReyHgFR4+ZwzmftYe+fdLG96/wLJATtl/10m7kurlLjdauBv
         uOlEfq4n9k/TV0BC2NpDFr9kT8j6xRlUCfg/7efTtLMLIEBr28umg+igxCd18lXi9JC4
         D6vCWovTYAC2FyUkdzTxSCSLh+DtuP/B49rIt+a4mBggVtwgUmCdxKK9SxmxOBWVwt0N
         LWQHO2xdEbW5gxnPRmdVYKK7ASDodDT1gfVqKSA79najdPAKB+Xl5V7Md3/OgqAYGPvi
         4Dug==
X-Forwarded-Encrypted: i=1; AFNElJ94KmN8NLSp0CHAQ0cFrUcJEKZCcEHZhVrO9AdCC8jw+ysFHg/p9hfGZH7MnJfHruyoJs4BtqX8GVU=@lists.linux.dev
X-Gm-Message-State: AOJu0YzCU89C/GUXgTcGY2Mprkcl+So1/ptfKDhv6c/M+zLbzAPwY3nw
	Ky4mgz/L4uYMqka0YtTP49Lt+UDXO76VNh42GGWXTdS+Nr6f59Oj57adL9K9gQ==
X-Gm-Gg: AeBDievk7ykm1TbGOtDlffeOw96qgnFUdW02B/jVEywmMkQK9hnGtH/+LbCXdztltY6
	wKiX1u7JsiV+r3JqSUevzQ1FoVqqS5MtXGxcUBKzfz9u83dikjVsjDjcsJe05mAIcHPDuUg6R22
	7lr271iF+st7A0A67inGme0foRXvngtzFDzg+Ca59yFn04kU+pnr7R8WjUmMvKqzB9JJGZ420j+
	AkaV6pBA3QHqaPkZmLHDaNBWe8iZb5KXMQsrPwu+3IcXrcXBhnYdawHjyHkxCIvGOnJE1f8QjZZ
	3JsR15BuyRX9iVCGGOPMZNygrU/nZXxfcmN7IQEUOCZCbWA2DB0cjKxymnEGOfEF6Uko5VI1y8N
	SxWi5zy3N8ARfKAkK+15fAXXqKKan/XQqv/SXgBS2lLoD1OLP3RYebcejEAIVvtzOYEoA5bJKbq
	OlTh99Avdh7SJdT2nmCmzK4CzGeq9kdm7rlDiQX60DccCJ4nYibG7Gh+XX
X-Received: by 2002:a05:6a20:e293:b0:398:b16f:7054 with SMTP id adf61e73a8af0-3a08d8a8949mr13648177637.32.1776663003767;
        Sun, 19 Apr 2026 22:30:03 -0700 (PDT)
Received: from smtpclient.apple ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f0811fsm6670452a12.0.2026.04.19.22.30.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2026 22:30:03 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2] sched_ext: Honor SCX_OPS_ALWAYS_ENQ_IMMED on
 framework-internal goto-local paths
From: zhidao su <soolaugust@gmail.com>
In-Reply-To: <aeW4UlU5Zi-XSd42@gpd4>
Date: Mon, 20 Apr 2026 13:29:49 +0800
Cc: Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FBBD5AAE-2537-436B-91AC-8031B02F2DB2@gmail.com>
References: <20260420035646.1715762-1-suzhidao@xiaomi.com>
 <aeW4UlU5Zi-XSd42@gpd4>
To: Andrea Righi <arighi@nvidia.com>
X-Mailer: Apple Mail (2.3864.500.181)

Hi Andrea,

Thank you for the careful review =E2=80=94 you're right.

I am not notice the  re-enqueue side-effect, will drop this patch and =
think again.

Apologies for the noise, including the v1 submission error that sent =
unrelated files.

Thanks,
zhidao

> 2026=E5=B9=B44=E6=9C=8820=E6=97=A5 13:23=EF=BC=8CAndrea Righi =
<arighi@nvidia.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi zhidao,
>=20
> On Mon, Apr 20, 2026 at 11:56:46AM +0800, zhidao su wrote:
>> SCX_OPS_ALWAYS_ENQ_IMMED promises that SCX_ENQ_IMMED is set on all =
local
>> DSQ enqueues. scx_vet_enq_flags() enforces this for BPF kfunc callers
>> (scx_bpf_dsq_insert, scx_bpf_dsq_move_*), but the framework-internal
>> goto-local paths in do_enqueue_task() =E2=80=94 PF_EXITING, =
migration-disabled,
>> and !scx_rq_online fallbacks =E2=80=94 bypass scx_vet_enq_flags() =
entirely.
>>=20
>> When a scheduler sets SCX_OPS_ALWAYS_ENQ_IMMED, tasks hitting these
>> goto-local paths arrive at dispatch_enqueue() without SCX_ENQ_IMMED =
in
>> enq_flags, violating the flag's documented semantics.
>>=20
>> This can be observed with trace_printk instrumentation at the =
enqueue:
>> label while running a multi-threaded fork-exit workload under a =
scheduler
>> with SCX_OPS_ALWAYS_ENQ_IMMED:
>>=20
>>  Before (scx_simple + ALWAYS_ENQ_IMMED, 2 CPUs, mmap-contention =
exit):
>>    95 PF_EXITING local enqueues, 95/95 IMMED=3D0 ALW=3D1   <-- bug
>>=20
>>  After:
>>    1030 PF_EXITING local enqueues, 1030/1030 IMMED=3D1 ALW=3D1  <-- =
fixed
>>=20
>> Fix by checking SCX_OPS_ALWAYS_ENQ_IMMED at the enqueue: label and
>> setting SCX_ENQ_IMMED when dispatching to a local DSQ. This mirrors
>> what scx_vet_enq_flags() does for BPF callers.
>>=20
>> Fixes: 3229ac4a5ef5 ("sched_ext: Add SCX_OPS_ALWAYS_ENQ_IMMED ops =
flag")
>> Signed-off-by: zhidao su <suzhidao@xiaomi.com>
>> ---
>> v2: Resend to correct a submission error in v1 where unrelated files
>>    were accidentally included in the patch. The code change is
>>    identical; only kernel/sched/ext.c is modified. Apologies for
>>    the noise.
>> ---
>> kernel/sched/ext.c | 15 ++++++++++++++-
>> 1 file changed, 14 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 9628c64e5592..0758f5e5a8f0 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -1859,7 +1859,9 @@ static void do_enqueue_task(struct rq *rq, =
struct task_struct *p, u64 enq_flags,
>>  * Clear persistent TASK_IMMED for fresh enqueues, see dsq_inc_nr().
>>  * Note that exiting and migration-disabled tasks that skip
>>  * ops.enqueue() below will lose IMMED protection unless
>> -  * %SCX_OPS_ENQ_EXITING / %SCX_OPS_ENQ_MIGRATION_DISABLED are set.
>> +  * %SCX_OPS_ENQ_EXITING / %SCX_OPS_ENQ_MIGRATION_DISABLED are set,
>> +  * or %SCX_OPS_ALWAYS_ENQ_IMMED is enabled (which re-applies IMMED
>> +  * at the enqueue: label below).
>>  */
>> p->scx.flags &=3D ~SCX_TASK_IMMED;
>>=20
>> @@ -1949,6 +1951,17 @@ static void do_enqueue_task(struct rq *rq, =
struct task_struct *p, u64 enq_flags,
>>  */
>> touch_core_sched(rq, p);
>> refill_task_slice_dfl(sch, p);
>> +
>> + /*
>> +  * Honor %SCX_OPS_ALWAYS_ENQ_IMMED for framework-internal local DSQ
>> +  * enqueues (PF_EXITING, migration-disabled, !online fallbacks).
>> +  * scx_vet_enq_flags() already handles this for BPF kfunc callers,
>> +  * but the goto-local paths above bypass it.
>> +  */
>> + if ((sch->ops.flags & SCX_OPS_ALWAYS_ENQ_IMMED) &&
>> +     dsq =3D=3D &rq->scx.local_dsq)
>> + enq_flags |=3D SCX_ENQ_IMMED;
>> +
>=20
> I'm not sure this should be applied across all fallback cases, it's =
probably
> safer to avoid triggering re-enqueues for the internal events, =
especially
> considering that the BPF scheduler doesn't have visibility into them.
>=20
> If we do this we should also update %SCX_ENQ_IMMED documentation, that =
says:
>=20
> * Exiting and migration-disabled tasks bypass ops.enqueue() and
> * are placed directly on a local DSQ without IMMED protection
> * unless %SCX_OPS_ENQ_EXITING and %SCX_OPS_ENQ_MIGRATION_DISABLED
> * are set respectively.
>=20
> But again, do we actually want to do this? If SCX_OPS_ENQ_EXITING and
> SCX_OPS_ENQ_MIGRATION_DISABLED aren't set, these cases are handled =
internally by
> the sched_ext core, so triggering a re-enqueue seems unnecessary, as =
the BPF
> scheduler wouldn't have visibility of such events anyway.
>=20
>> dispatch_enqueue(sch, rq, dsq, p, enq_flags);
>> }
>>=20
>> --=20
>> 2.43.0
>>=20
>=20
> Thanks,
> -Andrea

