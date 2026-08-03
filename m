Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1E93B4E8C
	for <sched-ext@lists.linux.dev>; Mon,  3 Aug 2026 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785746504; cv=none; b=LulYmrx71fUo2gg/83cGX0GBfYLXJlwjcLb0HIssQgxQwD0i+S/la5sCqrDM7l04c/8JN2xJ+Z0uzZhX0fY2nM1MA4Kgx6BUVG4ctwzh4wfMnk2MOWQFokTp9E0eP9nm3ZU2gFJcy/nFNGEHoYmGQXU5dhCWzWve7oQ3FJGeQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785746504; c=relaxed/simple;
	bh=1qZLkMzxbNVeupdxnfY1qtQ+t96GPwnCSyrC+92BIMI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RkrYSmos6LiFz9vZdpanChLWSPXE6MFd4IFPIeKQksg45IJ5tWpBoK5WVqg2Z52aN/48gfmhhEMFTySZsd7+Nz5bv69yCATvVT/dURzVDoj3DVo+BC2iha3hhPVlX1XM1UrZTaXgIRGQ/AUHr4ouYm9vVGpDsGhLIs+jHz594pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dXHmTQN4; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dXHmTQN4"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bfc3b84aso9634205e9.0
        for <sched-ext@lists.linux.dev>; Mon, 03 Aug 2026 01:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785746497; x=1786351297; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q0tDL/ftQGMKvtHX/czwWb9AVoAwimBy8i+zDmKBWzs=;
        b=dXHmTQN42ZPvehARscMD/p9wytdQG7MviEYzFztymoA/UxfzFdBXaDUCaWEZzmqaD8
         appH2k/hbQPp1CfkhfRLJuV7J5i+zRZjidJKNSB+2ssDALgCh6nPiLtBBbx+hqeAMd8X
         gxIqbRLyXlLdJf6p9S76eLHNQV1VqiY9/ydyXnPGss86pnzTCDNQsejTMpxLKa/UHWnl
         iL3jaMcWFliUFFk4NbBMQnElHZ7I87hxVRifYgL/6Sh46Tva2teJaiN3ad+6y+DVTNcd
         lvsKYS9Gp8mPZWa3xpo8VuG0QrJaIC/IQTYCxnv7NdPTSE5I7ct7cNpJ5YiQIItAurPy
         d+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785746497; x=1786351297;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q0tDL/ftQGMKvtHX/czwWb9AVoAwimBy8i+zDmKBWzs=;
        b=E6gP1L4AtJJm8JwH4E6uXqjhsjxxJlx2gFcupYk8nXwyl+w3PEg3VE/KH93fvwgLr1
         VJwjsy2dMaoJZ8UlNA5bCuSeCsV8jUO82Uq1um9UcZxdfalz5csnvGyAPtlzfMSyrim9
         Zi3KW6vHlyJROnTflaQnN/QG4PE4Kogh5tfh3YGqUThAKLbZ12JQuZiHAfApxinsJr2B
         qdIvCBkrOZTXxlHz9vpvTN5CARdy48vkM6juB4dpneZfsjw344nhTviRFhxyJDknZgl3
         1n+lpTdEutsLfA8iwAps3Aol3ODqP3/rt3GkNWnBD7eA8pqX55k3Of60lmHIK5UbfEvQ
         azmw==
X-Forwarded-Encrypted: i=1; AHgh+RreAgv9qxSJgps3hK80w26evYWJ8aNYqet3KY7Ko6f02J7VWVgtF/z1bmzX10kIqdvLJVowvRrlxGg=@lists.linux.dev
X-Gm-Message-State: AOJu0YwJnQjQwk2i0/DAXvD/JqOuYaeJIbk1kQFjFjrH0ClsGcmKhpyU
	eoamdoTjEPySLfi84VsFKOekPra8193oubuAnPOFjKkwTDXAtWLeq0uphbKg5xee46nUHQ2JcTO
	OypLX8TtER5oL0w==
X-Received: from wmbil26.prod.google.com ([2002:a05:600c:a59a:b0:48f:dc9f:6f1a])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:871a:b0:498:952:e276 with SMTP id 5b1f17b1804b1-4980c66c991mr235781265e9.8.1785746497363;
 Mon, 03 Aug 2026 01:41:37 -0700 (PDT)
Date: Mon, 03 Aug 2026 08:41:36 +0000
In-Reply-To: <20260803060930.4111746-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260803060930.4111746-1-arighi@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DKF6AV9R4G9G.21L9Q2OQGK74K@google.com>
Subject: Re: [PATCHSET v4 sched_ext/for-7.3] sched_ext: Fix idle CPU state
 initialization and validation
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon Aug 3, 2026 at 6:08 AM UTC, Andrea Righi wrote:
> The built-in idle masks are initialized with all online CPUs marked idle, but
> idle tracking currently starts only after sched_ext is fully enabled. This
> leaves busy CPUs incorrectly advertised as idle during ops.init() and until
> their next idle transition.
>
> Moreover, the allowed_cpus selftest checks that a remotely selected CPU is no
> longer present in the idle mask. An idle-to-idle re-pick can re-advertise the
> CPU before the test performs this check, making the validation inherently racy.
>
> Fix this by initializing the built-in idle masks empty. This makes the initial
> state conservative, so busy CPUs are never incorrectly advertised as idle. Once
> the scheduler is enabled and bypass is lifted, the existing idle re-notification
> path reschedules every online CPU. Idle-to-idle re-picks then populate the masks
> with CPUs that are actually idle.
>
> Also rework the allowed_cpus kselftest to replace the racy remote-CPU check with
> a stable local invariant: a CPU running a non-idle scheduling context must not
> be advertised as idle.
>
> Changes in v4:
>  - Initialize the built-in idle masks empty instead of enabling idle tracking
>    before ops.init() and refreshing every CPU under its rq lock (Tejun Heo)
>  - Rely on the existing bypass idle re-notification path to populate the masks
>    with CPUs that are actually idle
>  - Link to v3: https://lore.kernel.org/all/20260731182406.3166853-1-arighi@nvidia.com/
>
> Changes in v3:
>  - Reuse the built-in idle-selection static key instead of introducing a
>    dedicated idle-tracking key (Kuba Piecuch)
>  - Check the local CPU-idle invariant from both ops.select_cpu() and
>    ops.enqueue() (Kuba Piecuch)
>  - Inspect the idle mask without modifying it and perform the check before
>    calling scx_bpf_select_cpu_and() (Kuba Piecuch)
>  - Link to v2: https://lore.kernel.org/all/20260731090334.2911948-1-arighi@nvidia.com/
>
> Changes in v2:
>  - Move idle-mask initialization from the selftest into the sched_ext
>    core (Kuba Piecuch)
>  - Add a dedicated idle-tracking static key so transitions are tracked
>    before the scheduler is fully enabled (Kuba Piecuch)
>  - Rework the allowed_cpus selftest to validate the stable local CPU-idle
>    invariant
>  - Link to v1: https://lore.kernel.org/all/20260726064754.378671-1-arighi@nvidia.com/
>
> Andrea Righi (2):
>       sched_ext: Initialize idle masks as busy
>       selftests/sched_ext: Make allowed_cpus idle validation race-free
>
>  kernel/sched/ext/idle.c                            | 16 +++----
>  .../testing/selftests/sched_ext/allowed_cpus.bpf.c | 49 ++++++++++++++++++----
>  2 files changed, 50 insertions(+), 15 deletions(-)

Thanks Andrea, looks good to me!

For the entire series:

Reviewed-by: Kuba Piecuch <jpiecuch@google.com>

