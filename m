Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8CB1DDC28;
	Mon, 29 Jun 2026 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782764747; cv=none; b=f7t7t0Til0G+ZibMsIP+F8YOwTx4Tx4y/zbv317QVaX9+5R6z0B4KvIzOuhtCeZBcGvYXFKSyoUr78R58hbqe0oNNKgpMePtB3+NZsYv5Q4RJtrfEN8FfRpeuv6tbMLJOsYLDu61X02sp8ZOJSimIlhmAdn/ssxmqn+HfWf1epI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782764747; c=relaxed/simple;
	bh=qdYU/bSf6LLadGni+Kxk1fW265eoaZs78Yoz5MHEv2k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=C/YbokOwSb1EyRcLS+/qeJSyeQTAw9bFne4fqb5e8mcndY7ND2U3DBV+2YAoaTyeLygAux008a6yY4Oy/x+bO6VMVlMuN6W2RT3SAkLS/HZc39ix5pmNpZKd8G0KITTaC+xCHnDlyq6ZzMsiuXWefUzYtkrydKfvkFWU2rf/res=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwHI9mR9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwHI9mR9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09331F000E9;
	Mon, 29 Jun 2026 20:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782764745;
	bh=qdYU/bSf6LLadGni+Kxk1fW265eoaZs78Yoz5MHEv2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mwHI9mR9MM8G6iSUG00NOPZkD3/dw7uw2R5phC8rNPGWgSqfbg1Ntsh7O/d4yzfPj
	 1JiQ1QIvaAVoM4xNpmHkSmYm4N3j7ulWBOjCLkEGWlvIPH/ivGEytS0VbEc2t78HHK
	 /ShwzFtW869ZTvfirNLcBeNxE5HHqVkYOm9ea22nUWN5G/PNT9jOMpDMJmWxpCTZQ4
	 RuvLDomhd4+OVjx75dhFZ3c6ySjjw7qo4wpfpQYP3tExab9siA5E9oG9ga/uSYEl7z
	 7HY13UoUiI9qqs8fAY5RjbPP42P2u0y/PVPZ1kcZZg8ln2vvWSgzGjTJSwrQ6iGbIr
	 pKXZYjUO/31lw==
Date: Mon, 29 Jun 2026 10:25:44 -1000
Message-ID: <e8520c1a0d83563a33cb5de6f574aafb@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Pin parent scx_sched across a child sub-scheduler's lifetime
In-Reply-To: <20260625232356.3801838-1-tj@kernel.org>
References: <20260625232356.3801838-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.2-fixes.

Thanks.

--
tejun
