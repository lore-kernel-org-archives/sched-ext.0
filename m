Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790DC33F8AA
	for <sched-ext@lists.linux.dev>; Wed,  8 Jul 2026 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783548011; cv=none; b=YgT2pKohp7+W22sgjRaMiWfQcaxRoGL7EIAeMirG6uSV+37z7FjWaZsnlRDd3Ws3wHBr7jKXA59ix4XJS2dej1vMBDT9OimvWULJmIZD6/jJSZeyNeW6XKVEMIR3ITnEN7kfqd4+nLJbnT19hC5kV04+GlAA+UqFiQVrRL78z08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783548011; c=relaxed/simple;
	bh=/r+XXkrZDu94hxN/qXfUSRahmJVqy42BkEUODUZqInk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uEZTe5L72evHeSzMyhpZ3Kl5phSnQMPnw8aUPJQLxnSHPqmMuYob4RqE/i/iHpRoCYAr9g0662n6VydSfjvwtEWdtdcsVhy89hBDJeDeOGDcRMX3457BlhEqe+3IXBc9HL27m4mjB+c0fFd26xQo7LMwWJZObIHoPqpqc3KQnhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEKVEGGR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEKVEGGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27C81F000E9;
	Wed,  8 Jul 2026 22:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783548010;
	bh=MP+Vrf7wrwMquN87EKSXDULtKNcpARqN7Ib5lnEq5hw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CEKVEGGRcL7xU5dFxOot3/qcn3zZjU5aCEDT4OWDh+a91ms+KT96k3KgBqcd1b0AD
	 fDJ99bryFPPTUmAYaSGXASd/n9nJY5bopbrpLrj9Mo5PbvTory2THHlyO0MlwoCfbC
	 R+goWN7CHVMXKsw6Kl8+NXYzZaoMGsH98gPVz0DXtn4Y2gYY8uToZ5OLw0X+KohPpL
	 y8bJRu3U9mhP3CxpMDqK34tvprswi6NNJy11x5i8vYYZTjAKpanr0c4PFFx3qfQJUm
	 5lbKZV+65SGY15mSm2cfydzwMnwkJG7vrQZbAwNMXsUML7QRaXQpqGNNPrEyny1oiq
	 bX/iZ+pI9QTyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 sched_ext/for-7.3 32/40] sched_ext: Add the
 SCX_CAP_ENQ cap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260708212429.3405787-33-tj@kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org>
 <20260708212429.3405787-33-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 22:00:09 +0000
Message-Id: <20260708220009.E27C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Tasks with carried-in IMMED state are spuriously rejected during i=
nternal movements (like RESTORE) if the scheduler lacks SCX_CAP_ENQ.
--

--- Patch [32]: [PATCH v4 sched_ext/for-7.3 32/40] sched_ext: Add the SCX_C=
AP_ENQ cap ---
commit ff6a1550bc7578cdbaff320215c7593bfdd63815
Author: Tejun Heo <tj@kernel.org>

sched_ext: Add the SCX_CAP_ENQ cap

This commit adds SCX_CAP_ENQ, which gates inserting tasks onto a cid's local
DSQ. Unlike IMMED enqueue, plain enqueues can pile up, so ENQ is the strong=
er
cap and implies ENQ_IMMED.

> diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
> index e4c645dfbf7b5..1d278c0d16026 100644
> --- a/kernel/sched/ext/sub.h
> +++ b/kernel/sched/ext/sub.h
[ ... ]
> @@ -106,18 +106,26 @@ static inline u64 scx_missing_caps(struct scx_sched=
 *sch, s32 cpu, u64 needed)
>  /* map @enq_flags to the SCX_CAP_* bit required for the local-DSQ insert=
 */
>  static inline u64 scx_caps_for_enq(u64 enq_flags)
>  {
> -	return SCX_CAP_ENQ_IMMED;
> +	if (enq_flags & SCX_ENQ_IMMED)
> +		return SCX_CAP_ENQ_IMMED;
> +	return SCX_CAP_ENQ;
>  }

[Severity: High]
Does this code incorrectly reject tasks with a carried-in IMMED state during
internal movements?

When an internal scheduling movement like ENQUEUE_RESTORE occurs for a
running IMMED task, scx_do_enqueue_task() preserves the task's SCX_TASK_IMM=
ED
flag by jumping to the local_norefill path.

However, the enq_flags passed to scx_dispatch_enqueue() and subsequently
scx_local_or_reject_dsq() do not have SCX_ENQ_IMMED set.

Since this function only checks enq_flags, it evaluates the requirement as
SCX_CAP_ENQ when called from scx_local_or_reject_dsq():

kernel/sched/ext/sub.c:scx_local_or_reject_dsq() {
    ...
    u64 missing =3D scx_missing_caps(sch, cpu_of(rq), scx_caps_for_enq(*enq=
_flags));
    ...
}

If the sub-scheduler holds SCX_CAP_ENQ_IMMED but not SCX_CAP_ENQ, the capab=
ility
check fails. This causes the task to be evicted to the reject DSQ and strip=
ped
of its IMMED protection.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708212429.3405=
787-1-tj@kernel.org?part=3D32
