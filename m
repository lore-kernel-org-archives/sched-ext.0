Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EC93B0ACB;
	Wed,  1 Jul 2026 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938650; cv=none; b=QsXhguZsfqmv4JO/PC31oENgd6Dj1Z1RMSSQclmrXL1TWDy5OJQG4HOoxG9olK02B1II9A5eyQOl6YalcnmdBg5G7s+OqA/NjF4NQ1d7xiPr6182j1G09hOpI/pf4xw0mHMjTmIeJAdjS74xU36zXC7c2G3ocwCBbgBHzoKyXZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938650; c=relaxed/simple;
	bh=qxaGXMQc3jt6VVA5w4TJnJoORphubhT5qy72SVgvOoM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=oWHaQc+FIiqPhYrBsePe2LKkknAYkQhh4HkjpzKZ3bjHWEPkUfVxsR94t23TpUUSnuFq0R4Sf1H/SI6ssDmMwisLw8w23bltIWRzdxCBGU3oh/qH7X4LDuRb+TjaeOR5Xx7E02bipf4zp6T733Qk523J3KXFsEX9yTVb7E7OD50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlOxyTLS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlOxyTLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E011F000E9;
	Wed,  1 Jul 2026 20:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782938649;
	bh=qxaGXMQc3jt6VVA5w4TJnJoORphubhT5qy72SVgvOoM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XlOxyTLSADfnnlNxaPJhtuWlzywKqR5NMYJr8nxmZTQ372drlsCO+1bvDXYnTTci8
	 2yN+TenG0YDDn5aVsoUaGW16WcIAVninZ16JityRyLfta7IFfgym2/devTCuE7OSn4
	 bmG4ysm+Yj5j2SZk/sj4hIGokzVjBlByOlsa7cK3e4XOXjxziFg+jibcdi9lcboiCp
	 QsQdI5NpuETbtgNH8p+meU/EN9LJiH9qiGq/hPuo7fv4+g7OnP3kywApHSmI4t2cGD
	 aLGij73WyR4AE4vZiUGtTQ0s2pFjMlCApH3TySQAcTUROJRXGRNpIkWM5+6GTVylpw
	 GtRsEYWpLAb5A==
Date: Wed, 01 Jul 2026 10:44:08 -1000
Message-ID: <9feb662351c75e0b566a592b9a7c8b89@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHSET v3 sched_ext/for-7.3] sched_ext: Split sub-scheduler
 implementation into sub.c
In-Reply-To: <20260701203438.2837392-1-tj@kernel.org>
References: <20260701203438.2837392-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied 1-4 to sched_ext/for-7.3.

Thanks.

--
tejun
