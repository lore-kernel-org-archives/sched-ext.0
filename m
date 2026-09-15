Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860504B337E
	for <sched-ext@lists.linux.dev>; Tue, 15 Sep 2026 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491255; cv=none; b=aI3+kmIqtQmF4TUY6UtX8fldLqRJSI9dcd3eoT5FmPvsOWeMBvYh0CngJjCjvNS5Eoy52M6zZ31S2X50NX7jVUq1In9hQvbwuT/1R5j1LYyvCE+dx/5jdMoCQG4+U3DNVrN4Uy0xBWD3krrkGrwz07y1Wu8Yapy5N+GUHLGtRjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491255; c=relaxed/simple;
	bh=7lQdceQEdvNvvXX2CI1Kaonl5TZf3J9+900uuOrpBIE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=W2jbKKZ3AuEWNYSuCb535+XvuEF7XiWXC0lWZR2qqO4cIbDgmNONMFBrwpEj1WuYMdpaDkDudfff3x9g3PYW+4IAc7SyCgq//rgPZTmMW5gtEL8a14OS/tCOpOJvYrNFKIK3DFTMXWkXMcPvBmJRP7aiFAolPI2EjB+sR1plwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0Bodanb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0Bodanb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D951F000FF;
	Tue, 15 Sep 2026 16:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491254;
	bh=7lQdceQEdvNvvXX2CI1Kaonl5TZf3J9+900uuOrpBIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V0BodanbndwejhZh0Fbrl1cLKifV123ZUYdqitInQYSx2XKBPk3b2eT0zsIw6Wddo
	 si6OVQpcGUHXe3h+OdQDiZzbCkRSDbtyIhyjVh+oVVAJSIJRZO8918NGIrdqbM+TA5
	 IpFlujjwvUC+jQz3IRbrtV6dSd/HL1zW4pFGYAt+BvvxCl0Q5CSMeSPfBUaRM1e+pN
	 jxtX0MHh0+yI1GrK+js7TK3JK9roUpkxvwzfZZy7H9FwZrFI88bj3SpX2ctgBErJSD
	 HQaTlr8FUVEYK3n/ke8TDqOETXwFHia8lZ/NOtTy2anZ8T+DGjhhHQtw7xqttHkmDs
	 a63K2aT+ykSFw==
Date: Tue, 15 Sep 2026 06:54:12 -1000
Message-ID: <a3c4830e2eb2525d37e3327b628ae73c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: Tejun Heo <tj@kernel.org>, sched-ext@lists.linux.dev
Subject: Re: [PATCH 2/2] sched_ext: Maintain an online cid mask in the
 scheduler arena
In-Reply-To: <20260915085819.5DB991F000FF@smtp.kernel.org>
References: <20260915082725.3881071-1-tj@kernel.org>
 <20260915082725.3881071-3-tj@kernel.org>
 <20260915085819.5DB991F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Tue, Sep 15, 2026 at 08:58:18AM +0000, sashiko-bot@kernel.org wrote:
> Does casting mask->bits to an unsigned long pointer corrupt the bitmask
> layout on 32-bit big-endian architectures?

The mask is only allocated for schedulers with an arena and BPF arena
support is 64bit only, so unsigned long is always 64bit here.

Thanks.

--
tejun
