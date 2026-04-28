Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2522FF672;
	Tue, 28 Apr 2026 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394843; cv=none; b=fgyvUItb09Vp3AvrS2GFQTj49C7oHqtFVH2OeV/82Zn6IgvCrGtKYUorX/nG2/Dz/PW3UZRtXDzrqgyr4PLBhXwtSz/hdlk5Oj2RVWJUS7ocJm3bKb6wQFaGNAaFZe9WL6B2z/QkW76pAGRubYSY0XxE/miaE0jGK1elveT2Qbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394843; c=relaxed/simple;
	bh=NBaMwynNyfEDNXsdyD8HrplS1q1uhkhyL5Br6EL6lPQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=o8GKN5VCe3dRfN7iVm1J5lveqPzwYfRRxrCokc8XD4x3cYwL8oJin8BrMlttiBlw69ZYsV8dVFtudt81Gv6M3dIAMsK9nDn5g7OPK75qBS3WzwVFDaeGazXwe8LpA4APsWvgl1kBxvmFXnZe2Gw2d6eV/SjoLspp59cyQ0kVuas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMVLEV2u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMVLEV2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB099C2BCAF;
	Tue, 28 Apr 2026 16:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777394842;
	bh=NBaMwynNyfEDNXsdyD8HrplS1q1uhkhyL5Br6EL6lPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WMVLEV2u4iHBcUhss1rZXUsooQ1Vs90QHlwmMCnZHV9a9+kdXZsRukPelqKRdaI5f
	 nds4qevc4KfzaDB8BX1XsaYWQdrYwcri4Xm5jeTT/prqhH9vGO9u1GUOuUe4OhlGot
	 9M/XJA4MCsg4FAERsen71FAm2dPesZCgvfVyKNGK6rVRMg7bk5li4yrXQTrE8o8kZ0
	 qPlsJWzgd+crjhPZOUVkuJ9qiihXY7jvrMT+BOLDxfYfykdshJxI8Q2BfnOItmk6RY
	 Wy6nxBE9npxf+L3VBLN9fMNSk7L2kTYTY0gzIb7p5mzZcj3HgBzhF7az/UCxOx2zK1
	 M9oiMTWKkuiiw==
Date: Tue, 28 Apr 2026 06:47:21 -1000
Message-ID: <50f2af17799812657d016612ebbad3a8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Collect ext_*.c include headers in build_policy.c
In-Reply-To: <b7ce63c1c16b6a21106b4fde986c3778@kernel.org>
References: <b7ce63c1c16b6a21106b4fde986c3778@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> Tejun Heo (1):
>   sched_ext: Collect ext_*.c include headers in build_policy.c

Applied to sched_ext/for-7.2 with Andrea's Reviewed-by tag added.

Thanks.

--
tejun
