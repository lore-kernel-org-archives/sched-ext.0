Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478B71DD9AC
	for <sched-ext@lists.linux.dev>; Sat,  4 Jul 2026 00:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783126480; cv=none; b=TQgwPWGBFfBdwzPGStIP8j1WYj0UAYj2Og9DIw9Pmf1X5aGHXgHk0D5sjRj08N899Ww5HkRS8AYWaPv4PiQCOfIHAqcFe1txYqVHfROuieYrXwXEtj53vi5O9GvJyauarP2Rj8fb9iGNhlh5do/whghLORvsGdscINVJ/lyU3eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783126480; c=relaxed/simple;
	bh=Q2kYncF/WxadJoQmMJakTah2fcK7EugOjRAzVtM4EY0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=gHJF8fSWnyuffOUxmIuWzFOraGA1dsBBu2n5wBaNXBRcyyfDR37WG9fHOybdTnX3siXJH2RyoWJxWdUk1nBcFYxawKnom5kciwuywQwMQEgW6Zee02/5EYLF1MMBlNyWelL04H7O3osgu5taf0qwM72aQBuGP2mKQWy9OTpj4MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdhU6Wur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdhU6Wur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2331F000E9;
	Sat,  4 Jul 2026 00:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783126479;
	bh=Q2kYncF/WxadJoQmMJakTah2fcK7EugOjRAzVtM4EY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NdhU6Wur4UOuOCasCLQNfdDnBxQ2G6sG3GRsqzWrmwHb6S5sb8ehsjasYDBvF9y6x
	 voLmwzAjaHirDq3vR2AywZ9pNblH0heUSMAme/awRoJKUsn5jt1hk++WLVWg19JmIo
	 adPHS09fOOr6J/DiaAWwBjB6Sp+1xK/PcdGZ6payk79Vc7tPpOR0CSLk+jSKjjtppO
	 8M24x/+ClGfxZNrElT3qLdsloRPqTMZZtj5BhJW7vJLK546WsVT9k3h41R8a6CVG3E
	 RWUxeqjTvxkxbPpsCmSzfy7o69P1kHk2LW3aDhgh2w7FmIajuurL7RHuQ2aPHLK1cp
	 jD/wBQxtgpcxQ==
Date: Fri, 03 Jul 2026 14:54:38 -1000
Message-ID: <d6ab6600492da29658f71926ad155994@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3 31/32] tools/sched_ext: scx_qmap - Expand hierarchical sub-scheduling
In-Reply-To: <20260703145724.006E11F000E9@smtp.kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org> <20260703080159.2314350-32-tj@kernel.org> <20260703145724.006E11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> [Medium] Missing atomic increment for sub-scheduler dispatch counter
> (`nr_dsps`).

v2 will use __sync_fetch_and_add() for nr_dsps, matching the other
counters.

Thanks.
