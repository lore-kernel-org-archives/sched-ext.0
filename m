Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520427;
	b=oiivfHlU3RPbnOwnrbhKTWqImMXVbYEF2jjvGqGNxMprlahHWqgnKQ+YEq/acJonh8fP
	 phvtaKnNU6OvhRHHmOBCRjII6p5kBsO0N5aWDcr3YIZA+xIM47y31r8rgd0IwPyBXVhGl
	 CmplOpkHN+rq2SyX8OYR9JIFXxXx/+ZJO4Iw5/p6Iguve563rxkzuD443GWxMPuOeBfsD
	 DNLMI9xxu2fzKN39TIYiKxV66QXEJwSwyNQ8L0Xh8WL/XTpnS5BdZJd+u00WIZ6cFujEW
	 o6zZn9DSfUZItEzeMeNvVcCAu2Ws3eocwvm5okdF/+ZN3XTG/mZTSQS5MebZBosg/mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520427;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type;
	bh=ChclCwVXqVwfXDN+BPzeDgbBUmYNysPVyrbCOibkytg=;
	b=LTalM2NRdk/Wu3HRkhGD75cVraBu58n5/OZqsvbbP5Iatr4M3og6HGBxU4zBF+dqvn6E
	 L8ES257ZY6YoS03Gd5Us9UlTTzIdtfyymaQT58g7AuQTuy2msgn24LJIlggqZpE+Gx3BE
	 A8OGU0szgKyAWwHhmEinjdUgvqhxMN0horybnH3L5efwSC8EAKSNSeO6UIrvrhecR9p4z
	 6fv3gvE/YtixhSTqjRZgEUbfHESsMRbwHwt+aloJRcBGXVxxocp8lyXxgqYiCrtRD3FNx
	 ztIhZzt0goXTYMIPUTQgHvQ+efrAOg9WkvzJ//GvVVpYE88bhsy79DJgGvj8e5fqi9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cwTOiavI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0060A2600;
	Tue, 20 Oct 2026 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cwTOiavI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C371F000CF;
	Tue, 20 Oct 2026 18:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792520427;
	bh=ChclCwVXqVwfXDN+BPzeDgbBUmYNysPVyrbCOibkytg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cwTOiavIYI8Nz05yMIqFIbSN4VsD4esm91yWjVVSEp+IkEFWLZ4CBNGj2OavnZhOK
	 EmRcLAewP4sJ5DxPHeOiNX42g/qQHcaOqu3zsfduP+ihzz6Owe5dh/XSI5sK/VmHm2
	 Ld1i2KSkonB9q8oxN291+PDeCa1jbOs7jU+Q+lhqR6PyPfx4W3qHsx5rLimLA19eEc
	 E6U2q3EYs5WuGgwtgxe2H38DvgMqtnyM/ZZFnSM9sNSLCT56nS5J7DeM9eIDRfF+MY
	 4wLZKmneZf3oYLfHdHCKClBYaM6RAaA4YvKDpkBqroWh4P9p6XfOvey1G6Zn9E1hHS
	 WoildYVbCuswg==
Date: Tue, 20 Oct 2026 08:20:26 -1000
Message-ID: <6ac645ace4ab4023b24e8aace406a072@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched_ext: Use irq_work for deferred actions with proxy execution
In-Reply-To: <20261020084400.845842-3-arighi@nvidia.com>
References: <20261020084400.845842-1-arighi@nvidia.com> <20261020084400.845842-3-arighi@nvidia.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Applied to sched_ext/for-7.4-fixes.

Maybe this can be optimized further in the future, but we should
probably improve the balance_callback mechanism rather than trying to
work around it from the ext side.

Thanks.

--
tejun
