Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689E3370AE2
	for <sched-ext@lists.linux.dev>; Fri, 24 Jul 2026 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784918767; cv=none; b=rcGTT9A1ISejGL88wiGHpbKAOADlRsXDWtQB/FOri82slavsF/NOO6WlotxWpxM4JVO9seD/nxnbbEnDJMcEGkaJSsedw318geLgX0DGRyjkqX8U4wVuiyEYt2szoIMSuq8rr067ET/LTc27Ppo5SNd8AUokjMHJKxzEP2WXhCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784918767; c=relaxed/simple;
	bh=Ly0ov8zda5c9oJZ5bHgUA5AfMXldGp+2nooUbWRNE2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SJaVlT4qgyBgH1hWQ2FQ5QRM0UBdqd7b8ZXbDsj9J5kfLuhlIv1+PiqbW3MkArWcj9bKKoA61mWfpUe0E/kJZqF7SQu6DJZldDhARywrYrNdXOP8/r50YczZFVfoidA2/+OQUQfNELZ1Pgox1Ht3EcTE3/PWgJ5CM9kl54rYkmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jh5peJlz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh5peJlz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6641F01559;
	Fri, 24 Jul 2026 18:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784918766;
	bh=v6o/s3tgQaxzX5mUrsQoOuVNVULnPyskacT3JaDuzPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jh5peJlzbhHn0O7wUPX8d74Ah+UtIrdehBa4YEa9k0pwWIcMJOqWbgEszHk4wfsBr
	 zmfs4sH6BabkUF2BIExlCr2iW5YvR8chaQqReH0BJgti9RjgsrrGDIZNpKcBZjvxGr
	 Q23F/uG4EdiervMSXK+MiN4JVD8B1RQepKpxsSxbXbd5myZ0SPPa5V9+qku/PO6Xzh
	 mqQLBRu51EQe1NDxaxWDpyJ4Hl7JJI6WAwddgev3JnZiOgKhP61WCF2lIKJQN/gqVJ
	 v98NM3XFnuUvvU3MYwJNTbjJ+5Wy6QMd35HxUjPPNvHGgPWBCjRB0TDNHOHaZ70AWj
	 v0OZe3knvxAxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] sched_ext: Gate scx_bpf_cidperf_set() behind a new
 SCX_CAP_PERF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260724182125.985061-6-tj@kernel.org>
References: <20260724182125.985061-1-tj@kernel.org>
 <20260724182125.985061-6-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 18:46:05 +0000
Message-Id: <20260724184605.EB6641F01559@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The scx_qmap scheduler breaks backward compatibility on older kern=
els by unconditionally passing SCX_CAP_PERF to scx_bpf_sub_grant() and scx_=
bpf_sub_revoke().
--

--- Patch [5]: [PATCH 5/5] sched_ext: Gate scx_bpf_cidperf_set() behind a n=
ew SCX_CAP_PERF ---
commit 3bc27e508735d52ab01e9e24c0c210b6cb92366e
Author: Tejun Heo <tj@kernel.org>

sched_ext: Gate scx_bpf_cidperf_set() behind a new SCX_CAP_PERF

scx_bpf_cidperf_set() reaches cpufreq with no cap check, so any cid-form
sub-sched can steer the frequency of any cid in its view. This gates the
operation behind a new SCX_CAP_PERF capability check.

> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index aead17658573b..8822ed11c0d8b 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -1585,11 +1585,13 @@ __noinline void apply_partition(void)
>  		cmask_copy(&qa.to_grant_cids.mask, &ssc->granted_cids.mask);
>  		cmask_andnot(&qa.to_grant_cids.mask, &ssc->prev_granted.mask);
> =20
> -		scx_bpf_sub_revoke(cgid, SCX_CAP_ENQ_IMMED,
> +		scx_bpf_sub_revoke(cgid, SCX_CAP_ENQ_IMMED | SCX_CAP_PERF,
>  				   (void *)(long)&qa.prev_rr_cids.mask);
> -		scx_bpf_sub_revoke(cgid, SCX_CAP_ENQ | SCX_CAP_PREEMPT | SCX_CAP_ENQ_I=
MMED,
> +		scx_bpf_sub_revoke(cgid, SCX_CAP_ENQ | SCX_CAP_PREEMPT |
> +				   SCX_CAP_ENQ_IMMED | SCX_CAP_PERF,
>  				   (void *)(long)&qa.to_revoke_cids.mask);
> -		scx_bpf_sub_grant(cgid, SCX_CAP_ENQ | SCX_CAP_PREEMPT | SCX_CAP_ENQ_IM=
MED,
> +		scx_bpf_sub_grant(cgid, SCX_CAP_ENQ | SCX_CAP_PREEMPT |
> +				  SCX_CAP_ENQ_IMMED | SCX_CAP_PERF,
>  				  (void *)(long)&qa.to_grant_cids.mask, NULL);
>  	}

[Severity: High]
Does unconditionally passing SCX_CAP_PERF break backward compatibility on
older kernels?

If scx_qmap is loaded on a pre-gate kernel where SCX_CAP_PERF is not part of
__SCX_CAP_ALL, won't the kernel's scx_bpf_sub_grant() and scx_bpf_sub_revok=
e()
reject the unknown cap bit?

Since they call scx_error() on invalid caps, would this immediately abort
the BPF scheduler and revert the system to CFS on older kernels?

[ ... ]

> @@ -1696,10 +1699,12 @@ static void rr_advance(void)
>  		 * time-share.
>  		 */
>  		if (old_cgid)
> -			scx_bpf_sub_revoke(old_cgid, SCX_CAP_ENQ_IMMED,
> +			scx_bpf_sub_revoke(old_cgid,
> +					   SCX_CAP_ENQ_IMMED | SCX_CAP_PERF,
>  					   (void *)(long)&qa.rr_cids.mask);
>  		if (new_cgid)
> -			scx_bpf_sub_grant(new_cgid, SCX_CAP_ENQ_IMMED,
> +			scx_bpf_sub_grant(new_cgid,
> +					  SCX_CAP_ENQ_IMMED | SCX_CAP_PERF,
>  					  (void *)(long)&qa.rr_cids.mask, NULL);
>  	}

[Severity: High]
Does the same compatibility issue apply here during the round-robin advance
in rr_advance()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724182125.9850=
61-1-tj@kernel.org?part=3D5
