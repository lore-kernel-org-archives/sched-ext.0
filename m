Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3139DBCA
	for <sched-ext@lists.linux.dev>; Mon, 20 Apr 2026 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708128; cv=none; b=gFOlHqqVNfbqGVHRgLSTOO2lgCn/ItH0GLPNDKclc8V0agEco2byTAQTa4fQgsY7hb7YmDB82VbD63ZIQKA5hAJmFhO7XUggeqp0QX7ietVU8L7SX+6VJAyTgYtcQVYYqAfd5cfHM0C5XAjbhx+0N+3wkrzNf+p6QomFhBSN9NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708128; c=relaxed/simple;
	bh=tandfXM05uQIbshPDvj0Of1sXuKpqoQ53wXz08/2Dq8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=j5IJfYjgOE/z+BrMq6ZSFMUAFexH2pujLXzYt5p28lJPvCT2W61Mko9y7BqaKNB2JhuW18R53+Rhwo6AQPv5myEWQd8ywteewAooXue3MPtf2dDOPcLI90S6VE85Be77bIV/0ETWechO1ioMJlI9R/Hr/muxl/HWljfZSqFFg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BICOdFUQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BICOdFUQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FACC19425;
	Mon, 20 Apr 2026 18:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776708128;
	bh=tandfXM05uQIbshPDvj0Of1sXuKpqoQ53wXz08/2Dq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BICOdFUQTLtSLOzEsiu2G3pCr47PujTMxgHZ5UhKiVv3lRaVr3oALI9Tu8lfO/ZlX
	 2eqhlu+IB9OxzuF+LcdCieiVkMpOAA/ohohb4XM4bHX6/6WcR9CUqJFajyl8+F9F14
	 yzLREQlOzb4FzK62JRs2bjontTAQKsckbvtZO9uaaOaRooaXNDYm0x/GbYlKP1jQz0
	 FiNyLgPhY0sxi92akgxnY6rLXQoewaz8tiYFKXgUrTBrez9dGxvoFcqcSIiEhFigEF
	 MGmbtuHfpl4J3/S/1BYhKNqsP0MgwVWdkaymFLFkbd5d7JAKqGBSLFCZ6RvjGVjqkI
	 OnZTyXIU0OU0A==
Date: Mon, 20 Apr 2026 08:02:07 -1000
Message-ID: <3851843956a109fb053e9fca6d1bba15@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1-fixes 0/2] sched_ext: Deny
 SCX kfuncs to non-SCX struct_ops programs
In-Reply-To: <20260420092913.440989-1-yphbchou0911@gmail.com>
References: <20260420092913.440989-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied 1-2 to sched_ext/for-7.1-fixes.

Thanks.
--
tejun
