Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC16C3783C5
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255919; cv=none; b=FeLtyFMNLsW8+/K0ZeYs8ksT7vXy6L8AB5S5d87q6L+Wy3XzC3aDOpx2GNA92xq6Hmf6BtfQoF++qno7Rn6LH6E3uwDSI76K9L3Z9LBRfNbplX0lrDMzCLQYs4KbrEXGzI3Zm5vKsk2l6zOUCdRUNvSlHqSzJJ3OymV776Mz/Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255919; c=relaxed/simple;
	bh=svxUhUDQRdzMigLgblyWNz1NW3Cx+QppJNs73/lezy4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S8pdTApREakSt7EpOpXMVrfSJortRzsZjulaMGJBh5As/MzZZlTKh/F+HdchFz/+6Y/C8GXeYZL0qE7TIhH72Tndamqjha4D8h44RzCzMIkZdXRqIJ7lVJUKN4aZdPtFu+mDHwcM5p1CLkBcrz+E6ZfFOqNb5bh15kMbMRQTrrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AF+36cTK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AF+36cTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594121F000E9;
	Tue, 28 Jul 2026 16:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255918;
	bh=AeUYIjoBtr9WOI3BoRLbfAq9D5s7mUKt5yh/XaVJ7kg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AF+36cTKQLVA/70N6WrfE17Z92NiOw9rEs8788XAiIUqjaFTlzjQ4Yp/o5gUWc2Nr
	 QSxiYZjOdWcZ8dlL6cwrhbDRp8DpFFs+AKPDKXHlNy4gaa8Zh4wk0JO6wmlHrgsnFs
	 lKmLktrMJpyWi6Gy04Vw20hlIXSCi64qHqp5f/f/t6fe9O5Pfgb7wuhg59MIYHbFdp
	 GIeklx8UDKNRL1QczHjw0Mi3QLQDe6VggYLr90zsqnahI+YysdyWDFfsvgmxmQFeoC
	 /YGhbU1ZZy5RofLmYhEFRR2IwPq9qaStb1CdwfnaQjdQuyhxp8wX1hzAuDnuLgtQ7S
	 Hjc5hikCCecUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/15] sched_ext: Split curr|donor references properly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev
In-Reply-To: <20260728154425.1549660-12-arighi@nvidia.com>
References: <20260728154425.1549660-1-arighi@nvidia.com>
 <20260728154425.1549660-12-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 16:25:17 +0000
Message-Id: <20260728162518.594121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Documentation incorrectly claims blocked donors bypass ops.runni=
ng()/ops.stopping(), contradicting the implementation
--

--- Patch [11]: [PATCH 11/15] sched_ext: Split curr|donor references proper=
ly ---
commit 5cd9f3cfe50f459bfe5f1a7d7f7b8af97933ae95
Author: Andrea Righi <arighi@nvidia.com>

sched_ext: Split curr|donor references properly

This commit updates sched_ext to use rq->donor as the scheduling context
under proxy execution instead of rq->curr. It updates references in various
scheduler hooks and BPF kfuncs, and extends scx_dump_state() to report both
contexts.

> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/schedu=
ler/sched-ext.rst
> index ad2fff3c05937..db1ef89ed8f2a 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -487,6 +487,12 @@ and edge cases, to name a few examples:
>    class, in which case it will exit the tick-dispatch loop even though i=
t is runnable
>    and has a non-zero slice.
> =20
> +* Under proxy execution, sched_ext continues to observe the donor as the=
 current
> +  scheduling context. A blocked donor does not enter an ``ops.running()`=
` /
> +  ``ops.stopping()`` session because it does not execute itself, and the=
 lock
> +  owner executing on its behalf is intentionally not reported through th=
ese
> +  callbacks.

[Severity: Medium]
Is this documentation accurate regarding the implementation?

The documentation states that a blocked donor bypasses ops.running() and
ops.stopping(). However, the implementation invokes ops.running() via
scx_proxy_donor_start() when the proxy execution context is resolved, and
ops.stopping() is invoked via put_prev_task().

Could this contradiction mislead BPF scheduler authors into believing the
task lifecycle state machine is bypassed for blocked donors, when in fact
the running session is maintained?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728154425.1549=
660-1-arighi@nvidia.com?part=3D11
