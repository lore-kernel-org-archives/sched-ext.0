Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1071D8E01;
	Sun, 19 Apr 2026 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776629961; cv=none; b=W5OSkZzdtNOgwWpZCgK1JmJkyX4ukHySSQXhkIBO7KWfL0X21ad5n3znf11cQl5x63wuy5jtf/ydkVO+6a/fBf/Qns2ywCDaz5hOe1OmwKbz93drryhXgOMjUQlX4tKkCEIAdOXI/AawEZEuSSxLP56r3kgbALLMrQrToDWl6Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776629961; c=relaxed/simple;
	bh=BpUlTZdU6iKLJyHy74DVgUbJssdVdz1upreAoZlF8RA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=dNu+g89xG6npiG7hG9i810rKM2WLRcOt6xy55dStDUIkon0tSmdzY/UZ6L3hJFPzCpPPvKSgh3S2KQZcACNSzejQjqHrY5H8TVQi/iQCLQQt92RP6vgQQl2iDfj8qa+hzFCmRlNvHjvuUdHY4M9aIJXfXic8ZaulfCCk2NKwgik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIuPxm68; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIuPxm68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487EAC2BCAF;
	Sun, 19 Apr 2026 20:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776629961;
	bh=BpUlTZdU6iKLJyHy74DVgUbJssdVdz1upreAoZlF8RA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IIuPxm68CyJVzxLY9R5aigR3lHkgBrn6CbpxJgeGdZaovU2dhXTGo4ScybcPu6wsi
	 qzSOEUQk9WmC0xNWTzMaV9vB4s1lqeHUc9BX0BBwnox9Z7HBsH3vL4EtoiUbSeuWKf
	 7jMSkIenNrgjCN6skwq7cp+2ObdWrFU39KbTjFzh+gUdmkpRbG2JBab12pPS8G3EhH
	 LyGNEJniGwOjeDN9rlCow52yr0hCUZ+4rWsEmJS0UKwQ+ngy+kK0Ys0MG+f6q67q1W
	 FpEL/4DBUCBGX7HHhNy4lbYXzlv1pmjPj70qrYeW3R6AxI7wMohyIrX1BdVZt52Xos
	 B4NkUjkpZG1FQ==
Date: Sun, 19 Apr 2026 10:19:20 -1000
Message-ID: <f5863345b14bb7b278641b3e2369f713@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev,
 Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 sched_ext/for-7.2] sched_ext: add p->scx.tid and
 SCX_OPS_TID_TO_TASK lookup
In-Reply-To: <c3069bb592d7d09790ca9ff6d9b7d3b2@kernel.org>
References: <c3069bb592d7d09790ca9ff6d9b7d3b2@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.2.

Thanks.

-- 
tejun
