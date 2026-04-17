Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DFB1A5B84
	for <sched-ext@lists.linux.dev>; Fri, 17 Apr 2026 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776451109; cv=none; b=fs260Ub0tM8zA1CYRBJzgwynPYqGkivYG5nAGDSLQDVLO4WdtYX2ApsFwxE7EZ6XSATHkga2+rXISEpdQKls6bmcBjhlt1fATNt2bztwE3FovvwDOnzu6pgdo9DnMXfv4xMJ5xZpiFRMZw4QhiNVG9hheKsSWCeVtO566nOjEwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776451109; c=relaxed/simple;
	bh=+KpSgwYPCGqdt6avlWOsU81LS/KFZBqht1Uj7jseeNs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=rKCz6D2TfrpJbuMGU48mS3kd5OG0bx90rx6rsJxjiLulkMI7JwXVwmBPyyWNS+bakoWjZvMRe2ysMPnbsvDRDPaneMHh+Yaq1LXOp4NzHt2HzCmliiK9kZ5x0k1/Sj8h9pAfkvdnEb1XGuMBfLBu3m2mWiQR2x2Onuy4T+D+HAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJ7F7djs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ7F7djs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C69DC19425;
	Fri, 17 Apr 2026 18:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776451109;
	bh=+KpSgwYPCGqdt6avlWOsU81LS/KFZBqht1Uj7jseeNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MJ7F7djsxMImISit6+2j/QjC/YpVQHDCyChLz90Bt6N0EoOgOhKdP+G10jf2IvjJI
	 r6fsDQCiVsDezQCgjWyfl8P7AEilG8KmbfHCXOYc+CLAzgC9EX7ohWQZ+GgOnSVyUK
	 k7ECh1CNrGfGJ7dyPkJANWi3VEn75gnv91MqxGBt4Fa1uYpG612Nt7ytbcKUPdpSTN
	 c2xL7bKkFojSPnqjBM83uQ7g7zIAVWyqyt2KB9BTLa2aZiVqxAlEhX8lbQJzbATVDc
	 6r2F/Sy8DEY8uAdt3ZkQEdcp50UPzxTkrNM44eTOg2V1rze0bU+Sx80Rhv/n6RpfXf
	 VDoSYT16J000w==
Date: Fri, 17 Apr 2026 08:38:28 -1000
Message-ID: <46db71ab566022b4f834dddb2e343981@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] tools/sched_ext: Handle pinned tasks in scx_central
In-Reply-To: <3cpy5o3wdfqrmk7kuvwlvibnkesvzprjru5urhyvf66qytnjeu@jibpzykbt65k>
References: <3cpy5o3wdfqrmk7kuvwlvibnkesvzprjru5urhyvf66qytnjeu@jibpzykbt65k>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> Cheng-Yang Chou (1):
>   tools/sched_ext: Handle migration-disabled tasks in scx_central

Applied to sched_ext/for-7.2.

Thanks.

--
tejun
