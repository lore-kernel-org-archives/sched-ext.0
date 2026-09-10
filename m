Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869214718C7;
	Thu, 10 Sep 2026 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789076433; cv=none; b=eW2lXgRTr1/kAR/wJktGEb0iUIKF7DM9QP2K4sv86CupO3s4lz6DMIkxZajZh0lpLJGnIv0Xfz89c2NdhEnwEp1YhlAlZ4T//IiXEMFHT1taUmhthLxeMv0un0KSzGec0Fvp07BK2vh996XAvOj5BzowW3avoUMhFvE/5ecUtlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789076433; c=relaxed/simple;
	bh=hQ92hRM85W2yQ4BsOOsArTW4MSVuY99ohn7KXkLPlQs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=XTg/znVy+H8/yHEptNqNvC9riXSRc4KqSNnPqZgcQ2TK90QyoVEku0b/EpTHl3aVN9U+eyVRoIVUKbbdqN/OD+6iScbRuFXYWphXYR/mtyMOJ1PMcUjrzYBlnzysYK51gyQVDEOR9dLQjpNhf+qOo2m/Cq/nlN/tQgx5kcOjyaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aR3Mr/YQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aR3Mr/YQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8C71F000FF;
	Thu, 10 Sep 2026 21:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789076432;
	bh=iZOPSHl/wWbjfK2g/VfyZhH7RTOp8SRODGAYWEmztYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aR3Mr/YQkjpmCGJLy5mnEnbsh+mzpkQrncDf3YPfu24KGfjcrPT0bBV27NBZCUWh2
	 XqN5S6kbHT+wMOF47qEZO0kectBfYxfwhtwsk1Ywwszlt1tphCyg3blWlSRrL5/CoZ
	 AuIUxlggVX9npA4JVIZiknqxEJz1gfHAudNelI+9FGYTyvbnY0T7zteUPRpw0ID7cS
	 zve7ha7SYrGeadWG6XwNMB+i/FNWXaf1uKGlU5HljLwmVT3eaSaTUaaM6pQS7ClQGZ
	 VeUrTlLIkjBrLYfwuaQCBCXwFkVcZMajeJBeNkl3JSh7ACHJZNcvLUa12Ua4c3fVIQ
	 9yOgCUCtJJUxA==
Date: Thu, 10 Sep 2026 11:40:31 -1000
Message-ID: <c3b851d927a8be1a0038cb208d33349b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Qiurong Fang <fangqiurong@kylinos.cn>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org,
 tj@kernel.org
Subject: Re: [PATCH] sched_ext: Close the pre-enable ops error claim window
In-Reply-To: <20260910084533.2420199-1-fangqiurong@kylinos.cn>
References: <20260910084533.2420199-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Qiurong.

On Thu, Sep 10, 2026 at 04:45:33PM +0800, Qiurong Fang wrote:
> +		if (scx_tryset_enable_state(SCX_DISABLED, SCX_DISABLING))
> +			goto done;
> +		break;

Please drop this hunk. Once SCX_ENABLING precedes ops->priv publication,
scx_tryset_enable_state() cannot fail here.

> +	if (!scx_tryset_enable_state(SCX_ENABLING, SCX_DISABLED)) {
> +		pr_warn("sched_ext: enable raced with a state transition, aborting\n");
> +		ret = -EBUSY;

This failure path is also unreachable. The state was checked as SCX_DISABLED
under scx_enable_mutex, and no disable can start before publication. Please
move the existing transition and retain the reset on allocation failure.

Thanks.

-- 
tejun
