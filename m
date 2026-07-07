Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161617D6
	for <sched-ext@lists.linux.dev>; Tue,  7 Jul 2026 00:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783384332; cv=none; b=OIYVORylceKJqt6m7Km9J9+2CRdzj0jPaLlZkFwyEpLrrW1dfS1Wl+A/jI6Jtekp2cSFBofGnu2WOqQloyFq8SU0KPAGW04vNeTQwYLW+K11e3qPjuUg2DuNNPxEXSEuu/3YEpgDN7Es5QxWxbmXnx1ghL24saC1xFu8dBKn1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783384332; c=relaxed/simple;
	bh=BnZdgzaCnabjiJFtvqRf7FHTMEDl4UvOPxPev3GiVs8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HSuZz2KXTPDE2Mtu11q6LfDLVK3MIGTZPwHTkDpm7ccR+nb1VfrUYKfi40zcqLj83RomWUZjeKwiZrThx2y/XsJRxQqlA4ACccYkw0B8rNVy3I77j5h3SGjFJ7OsgqGSGbtwhk7WVDcbxXaz4wHjLdAeVlpR05HirRXThL3F1xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OElQx9jw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OElQx9jw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479301F000E9;
	Tue,  7 Jul 2026 00:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783384331;
	bh=AkMWqJqPlduChSkF0h5s7yvQZ0Dzi1YRP/vf8EONb54=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OElQx9jwRE1tvaAumNOFphaEOR82D5FZbr5piKRlguAhEHAYcMOqx1qc9R4p9VZ7L
	 Ghb92z0ipEuOLI4qZm4FHxDjw6q2gjeOIo52idVrQQqKmq6adt4XO7AEsRUKuhtqTC
	 fjGMBxY6qIl52TChWV7tKR2nYsDMgbrxesKN4bskn8pOopZc9ODxIZb8Z/543ChsKz
	 hpTQHT6if3x6NSB9O9aQohaYDQC2/JoAIcgIudXP0Weog+r6FWfEVk8b/O9eItqTad
	 B1/WuLcaTvR8/G97lYDhw1dXTgfvltFuBHV8KHJonNkrJcmq1BFYL0iQyDQrDJjZ7S
	 uLLO6tjA1P9RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 25/36] sched_ext: Add the
 SCX_CAP_ENQ_IMMED cap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260707001229.1410929-26-tj@kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org>
 <20260707001229.1410929-26-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 00:32:10 +0000
Message-Id: <20260707003211.479301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The SCX_CAP_ENQ_IMMED capability inadvertently allows sub-schedule=
rs to enqueue non-IMMED tasks to the local DSQ, breaking the CPU isolation =
guarantee.
--

--- Patch [25]: [PATCH v3 sched_ext/for-7.3 25/36] sched_ext: Add the SCX_C=
AP_ENQ_IMMED cap ---
commit a4e853c803659c3e80f2be7fcff03bb32c0a8907
Author: Tejun Heo <tj@kernel.org>
sched_ext: Add the SCX_CAP_ENQ_IMMED cap

This commit replaces the dummy placeholder with the SCX_CAP_ENQ_IMMED
capability to gate inserting IMMED tasks onto a local DSQ. It is intended
to guarantee that IMMED work gets running at once or is handed back,
preventing tasks from piling up on the CPU queue.

> diff --git a/kernel/sched/ext/sub.h b/kernel/sched/ext/sub.h
> index 51400e174cd00..f3548976800b0 100644
> --- a/kernel/sched/ext/sub.h
> +++ b/kernel/sched/ext/sub.h
[ ... ]
> @@ -106,13 +106,13 @@ static inline u64 scx_missing_caps(struct scx_sched=
 *sch, s32 cpu, u64 needed)
>  /* map @enq_flags to the SCX_CAP_* bit required for the local-DSQ insert=
 */
>  static inline u64 scx_caps_for_enq(u64 enq_flags)
>  {
> -	return 0;
> +	return SCX_CAP_ENQ_IMMED;
>  }

[Severity: High]
Does unconditionally returning SCX_CAP_ENQ_IMMED allow sub-schedulers to
bypass IMMED enforcement?

If a sub-scheduler calls scx_bpf_dsq_insert() or similar dispatch kfuncs
with enq_flags =3D 0 (omitting SCX_ENQ_IMMED) and without setting
SCX_OPS_ALWAYS_ENQ_IMMED, scx_caps_for_enq() will still return
SCX_CAP_ENQ_IMMED.

Because the sub-scheduler possesses this baseline capability, would the
check in scx_local_or_reject_dsq() pass and allow the task to be enqueued
to the local DSQ without IMMED semantics? This seems like it could allow
a sub-scheduler to swamp a shared CPU's local DSQ, breaking the isolation
guarantee that IMMED work can never pile up.

> =20
>  /* map queued @p to the SCX_CAP_* bit required to stay on its local DSQ =
*/
>  static inline u64 scx_caps_for_task(struct task_struct *p)
>  {
> -	return 0;
> +	return SCX_CAP_ENQ_IMMED;
>  }

[Severity: High]
Similarly, does unconditionally returning SCX_CAP_ENQ_IMMED for already
queued tasks fail to enforce higher capability requirements for non-IMMED
tasks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707001229.1410=
929-1-tj@kernel.org?part=3D25
