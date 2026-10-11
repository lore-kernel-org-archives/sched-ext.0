Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CFD385D75
	for <sched-ext@lists.linux.dev>; Sun, 11 Oct 2026 21:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791755234; cv=none; b=onts3LTYoqtfqnPDTjJWla9hZZ2XRJ4zVJYanVQEmn7/8r4s2er5dRl2eIMnijgJe8pNNQ1Lk7x00ccVVRwq/pvzgZ2ap8CappaqWPrlhBRPX1YFb8cDEGusGpJLDVngQ0ISi0XlbCYZVMYSqZUiafbx1f6/pZcvrA/vVVYggs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791755234; c=relaxed/simple;
	bh=qdo23Ya/RSTYNvF5Dt57TA0sLzBNQJty9rqW3CWWncU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ou86KB94SzsAP2r/XYwcmHJg/5xeV4+lZT3rinVx7dZBaxi6t/0xaKzy6SZrz49uAhMNiLC0BnugCXiu15SEyTEgSjXwuQUshfqJule3vZcOzjkCIHP+WCCSRy5DbrK+bc15uFNSk3ZdpojrZnoBoSiANzjFsFdhaFtu1rBpCzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zlb7uYKY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zlb7uYKY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7021F0089B;
	Sun, 11 Oct 2026 21:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791755232;
	bh=z/Th6lzp+ygVYZCV25n0f142Q1mRhPVCkCeKTFk5u0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zlb7uYKYs4j8QUYrQC6Fub2KpMwRvQNxte5tabkk4z45GSCV1yg7sFbA7z3p3nZAO
	 b5phn0ech33r3qN/+CF3R3reJFzbVHZtv7mFlfb9QAut8FxTRtElKipGBic02jb8NF
	 JIagMPY0W3MS5JYivL1kAAsrzwU7f4wP6kOLHpMaz2v74myNTeAsxhm0p/fQ5KB6Fc
	 o6yQsz3bL+0VPikbtYOJA8AyAri9qoDg7eyIkyoyRei0w1mrJCBQ7xAGPOepFEXL8G
	 wh2Lzyb89MNHGDPCZec+Vtye1ZEuNGbPeqkc2aml/eiWqGx9wUE6bg3I/E7opRdggg
	 RPZj7jDtVsZvg==
Message-ID: <sashiko-outbox-167465@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] sched_ext: Fix the bypass dispatch claim for
 schedulers bypassed by an ancestor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20261011214028.743546-3-tj@kernel.org>
References: <20261011214028.743546-1-tj@kernel.org>
 <20261011214028.743546-3-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 21:47:11 +0000
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] sched_ext: Mixing goto-based cleanup and guard() in scx_bypass()
--

commit c63689b3855e65ddcc5c7f3211328556c68f2c61
Author: Tejun Heo <tj@kernel.org>

sched_ext: Fix the bypass dispatch claim for schedulers bypassed by an ance=
stor

This commit fixes a bypass dispatch claim leak when a sub-scheduler's depth
goes from zero to one under an ancestor. It ensures claims are properly
propagated to descendants and released when the depth returns to zero.

Cc: stable@vger.kernel.org # v7.1+

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 7df47c6741009..630afee30c0c5 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c

[ ... ]

> @@ -6197,8 +6197,12 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
>  	}
> =20
>  	/* disarming must come after moving all tasks out of the bypass DSQs */
> -	if (!bypass)
> -		scx_disable_bypass_dsp(sch);
> +	if (!bypass) {
> +		guard(raw_spinlock)(&scx_sched_lock);
> +		scx_for_each_descendant_pre(pos, sch)
> +			if (!pos->bypass_depth)
> +				scx_disable_bypass_dsp(pos);
> +	}
>  unlock:
>  	raw_spin_unlock_irqrestore(&scx_bypass_lock, flags);
>  }

[Severity: Low]
Does this introduce a mix of scope-based cleanup and goto-based cleanup
in scx_bypass()?

According to the cleanup subsystem guidelines (include/linux/cleanup.h),
mixing goto-based cleanup labels with guard() declarations in the same
function creates confusing ownership semantics and is explicitly prohibited.
Developers are expected to convert all resources in the function to
scope-based cleanup, or convert none of them.

This patch introduces guard(raw_spinlock)(&scx_sched_lock) while retaining
the unlock: label and goto-based cleanup that releases scx_bypass_lock.
This mixing increases the risk of future LIFO ordering mistakes or
use-after-free bugs during refactoring.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011214028.7435=
46-1-tj@kernel.org?part=3D2
