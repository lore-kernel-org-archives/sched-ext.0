Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B9274FDB;
	Thu, 27 Nov 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258496; cv=none; b=Js6ypAQan8rpicvi4/feEEkPGhdE/wIw87ipXoo/3p+GQ36C7n0wIXvoAafEVLz1FRn0zcGzkdxb2GBiR5d2vrzu3na06kijrbC0L5lLzmUpl13TcCVnNKYsBwwZIR2KeCdABRU7wYfd2sBrtC5sUjZZ2H0X4GwBvO+tCjTkXnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258496; c=relaxed/simple;
	bh=sgRMHsbZNwWL05nnBZJ30zCT9th0pwdThCNxbiTqudE=;
	h=Message-ID:Date:From:To:Cc:Subject; b=cb2GM5AY+1E76FkxCX1j6/L4l2olwQl8jPejLLKzz+2TsxqTxUbgGlS9SE/2Q+lpEdb9SIe1gPR4z4gJZYwj11pDoEeVseOoUGVUg6x5DrN+QbxGRxPkhfJ4/DjFDaa26Mi+fyOlfD5YK6LqI+tIBo5CZg1mCZkfj1dlnODI7Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aG0szm+I; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aG0szm+I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=sgRMHsbZNwWL05nnBZJ30zCT9th0pwdThCNxbiTqudE=; b=aG0szm+IbkF0cKLufClw3EDX7F
	JYap/K9BNa1OSx0pyzS+5+lm9AOJFmk87yOAVEbWOOlk/K00RBjd6FoAgGVwGpV9Be2j0uhB6PtMD
	Euid1U0O9FXuYbRkQrdEFhyPq9e4xZEDS54YJy7bWFsSn7nOzpnHb91aKYV8MNuZ1nV1Fz4TUi27E
	zfTyXFeCfTDmCPaHqrnRPV2kxz3en2CK99OWWhIsza27GWgsCKjBeb4jHVBLDFEG4WxqtlRyRZwFy
	v76eN5FMWW68TnDbEu4EtyiT7F4pq/obJjoSUkXyIBmkjTdm+07+QD8A1hSrPJrFYom9SlA9mHYD2
	7Vvz5q6w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOeE3-0000000BwrA-3xO8;
	Thu, 27 Nov 2025 15:48:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id A1D1B300342; Thu, 27 Nov 2025 16:48:06 +0100 (CET)
Message-ID: <20251127153943.696191429@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 27 Nov 2025 16:39:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 vincent.guittot@linaro.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 sched-ext@lists.linux.dev
Subject: [PATCH 0/5] sched: Random collection of patches
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hi!

Here a fairly eclectic mix of patches.

The first is a very old patch I recently re-discovered in my patch cabinet.

The next two are cleanups that came about from the recent newidle patches.

And the final two are from an earlier discussion with TJ about tracking wakeups
across classes. This informs a sched_class it no longer has access to the CPU
and can look at pushing tasks away. The case in point was sched_ext, but IIRC
this very same point once came up for sched_rt as well.

