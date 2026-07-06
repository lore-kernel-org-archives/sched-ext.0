Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F062F3E0223;
	Mon,  6 Jul 2026 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783375778; cv=none; b=Ilpe2tsofN2pILB7RdTfwPEuVRDDaVsz6IZGWGzApcJ1Q6Lf5/mNwFdY4bRN8nCY3+WGSno0h8oP0ww06pJ1dne23MLBSWVruJEjujn0fY55lhnUJsp0bZZp5mAZ6lOQPN4lqPevKpbm9FBiF8Cc5D9hkpImSt60duB/MLqTKfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783375778; c=relaxed/simple;
	bh=7lbZuBKBbCW2c2Uw0gj1uTjIfjR485MRWBLqPsaLLBM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=il7ZR9kJaOdtFbOmQcTKltaw3sdAOByZiIBGMOoVxacYYqTA3fae17k/j4F/9zrOL5ugds9XRwFoAslYUhFdrj4mwjaQLlwVIiIpWOexA1Hatb2B9N9qoXc2lYsyjP+ouzIzwl60r5HcKpfNg+4xQ76jZsDZ1y0aZRA8RJpttjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iP8AKj5t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iP8AKj5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E621F000E9;
	Mon,  6 Jul 2026 22:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783375777;
	bh=Hj09wuL17EFOOvEPLfQfPKtY7y+Ig2aLu04SNIAVPms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iP8AKj5tE09wUOKL0jSxoUVVbMc1wSVK3jXQFHEsqoYCRtoGKrWr1s/U/y+Czubuj
	 FcPxWHm8tddDk1nJoX43GwamYmfqQkcF+0KQ9eR501YaeQO2iZpHhlMS9mnefONkW2
	 kdipe8YP32ZKmz7Ajw5hAEg5BUDQIJvw9QaEwjbmxYXI94XranxYt645D535e2c4W3
	 Sh0+xn0tHxOEzv8qs0EcqJm9sO5XBNVrTVZ+12aaei+kdvxpVHb3+4T3bsQ4WvHcLa
	 vhYJTriGQu7ZRXtOfLPxtwIbf91K8naTQg61HDPWAH7VRr/PUvulmhOtmOa2xsFOf1
	 lQzkeeD9M/p0w==
Date: Mon, 06 Jul 2026 12:09:36 -1000
Message-ID: <8bac2ab9236ec0c6db28debf4bf5157c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Enable tick for finite slices on nohz_full
In-Reply-To: <20260706162819.650155-2-arighi@nvidia.com>
References: <20260706162819.650155-1-arighi@nvidia.com> <20260706162819.650155-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

Sashiko's first point looks real to me. The fix covers infinite->finite,
but a finite slice landing on a nohz_full CPU after idle has the same
issue whenever the previous run wasn't infinite (finite->idle->finite):
the enqueue path already cleared TICK_DEP_BIT_SCHED against the idle
rq->curr, and set_next_task_scx() re-asserts only on a slice-type
transition, so with SCX_RQ_CAN_STOP_TICK unchanged the tick stays
stopped.

set_next_task_scx() knows the incoming task, so it can assert directly
rather than keying off the transition, like sched_fair_update_stop_tick()
does for CFS. Moving the finite assertion out of the transition branch
should do it:

	if (p->scx.slice != SCX_SLICE_INF && tick_nohz_full_cpu(cpu_of(rq)))
		tick_nohz_dep_set_cpu(cpu_of(rq), TICK_DEP_BIT_SCHED);

Can you fold that in and add a finite->idle->finite selftest case for v2?

Thanks.

--
tejun
