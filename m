Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50EC3B3C0A;
	Sun, 18 Oct 2026 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311363; cv=none; b=skiqDyxhoA4fpgWO3rd1uVOeAsVAg+dORTAFYn2o+jIveVMIBM+PuySJJsjPeI+C/iUjTamGwRQCQFfrInEEkiZpyuuVZ7RFKBDwjCLiMebJbD6E/JFkC0PdBEk/I1o3Y++lTnk+kg6bkedL6VbrQPKLsbRr1XBdu/krznm8I6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311363; c=relaxed/simple;
	bh=Vhi8xYqDxcBYdeALAxWqD2qF/iu5UpLnnSC8B9Tc4ZY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=lVIo5KKNe0y1++sSTlOPdY3Zo6aFCeJzIWc1W9zHbxUit5k1BBL5gX5UwXDbsaA9EqodrbxU6zAvGFTzArSqt3XjOay34+HrxCMffp/4mIZ6pVX+aCWbyZZc8V6as2PSaBFH2XcleT2U1Ve8ANA8tdSCiFyRGh3aMxmM5nG33EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtwDZv5F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtwDZv5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0F71F000C4;
	Sun, 18 Oct 2026 08:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792311362;
	bh=Vhi8xYqDxcBYdeALAxWqD2qF/iu5UpLnnSC8B9Tc4ZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TtwDZv5FCRsoKWrTqkXmHtwx5ac+PB85I+zFJtiBY9KzFB1+V7CS8D2X3Tdt7C7H9
	 6C2z8oITLGZRNuSauyRueSSw6idQP95Y4yU7C/f/Zn1a1pWx21aPBKoHSEJdeIVj03
	 q0s0Jbc8h/4RtknbfdqWSzAFLAxjj2kWOy7lLUzMd8kwfVNPhdFOawoPngbSqzeZ7p
	 6Px+BikbKgAbb71bXCgh9Qwoc9sV7rl48+wlfiepRnA1GC8nS8mpCyyNgQeDjVT+3l
	 crVxkB+K5UK78lQ+PJDI8/13bNjHT1CLxxhhz1WmJQHjg7NH6ezuNzIidUeRKgbsli
	 JfpucNAvAxhXQ==
Date: Sat, 17 Oct 2026 22:16:01 -1000
Message-ID: <cdba4a956a7a2e3079e27e536981ac41@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] sched_ext: Free a sub-scheduler a grace period after
 discarding its ecaps syncs
In-Reply-To: <atRtoSdf-c87N5tz@gpd4>
References: <20261018015952.1499528-1-tj@kernel.org>
 <20261018015952.1499528-3-tj@kernel.org>
 <atRtoSdf-c87N5tz@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Sun, Oct 18, 2026 at 08:56:33AM +0200, Andrea Righi wrote:
> This is called for every possible CPU from the free path of every sched,
> including a root without sub-scheds, whose nodes are never queued. With the lock
> moved ahead of the test, every scheduler unload now takes all the rq locks with
> irqs off, which on a large machine can be a lot of lock traffic.

The loop this replaces also took each rq lock once, and attach and detach
already cycle through all the rq locks several times, e.g. in scx_bypass()
and ecaps_report(). Cycling through the rq locks isn't that expensive.

> The first grace period has passed by now, so nothing queues the node again, and
> a node taken by an in-flight batch still reads as on-list. So, can we keep the
> lockless test in front?

A node taken by an in-flight batch doesn't read as on-list.
__scx_process_sync_ecaps() calls init_llist_node() on each node before it
writes the pcpu and calls the ops, so the node being processed reads as
off-list while the batch is still using it. The lockless test would still be
safe, as the second grace period is what waits for the batch, but the
rationale is incorrect, which is kinda par for the course given the
complexity of this path. I'd much rather keep it as dumb as possible.

Thanks.

--
tejun
