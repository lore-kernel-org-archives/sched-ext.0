Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062173D4137;
	Wed,  8 Jul 2026 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537781; cv=none; b=AZ9+7phqjTBSIaodZNxRwgZNdyKdTGe/J+ZapZD3E+dD1Ltn2eiRbHKtLimnSRbVbO+VuBk2c+gGMaqd9Vco29YO7h7oWvpBeQH9NldSAmCe+2vBJ1ysAulkbq/WJ8wOP4wxJ9tuGwxp5EtHG7WtvlaJffc9LsHS2/Jpy617XXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537781; c=relaxed/simple;
	bh=tppIEoAbO7Rk8g/4zB3pppIdyfXVltUjePlHzzb+bzM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=KxhcUCa7Ver0E06DzFN2DLFwb2AucqSe9KfNfXkpp1gjJsVFIz78j4db/TDJ5m3GCN7ObBjL0wdK7TBHmppSooPTTbHRsy1LtDd0R4RJBtEeS+g/L5LHXcb5TtXqF0hXve5kQdoN9OaVT5L/SfoksqXBCgFtvSAo2pcknS/td8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBfhx7CA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBfhx7CA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8A01F00A3D;
	Wed,  8 Jul 2026 19:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537776;
	bh=T/LlyT0MADLFQbMfzryd02pTh3crhMuvyCs2pJLcy2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jBfhx7CA0v2SPZjQd9+MRIXIefIz7MQ5HlbXHWs6v8tkrGcfr9E3uxHYhvi3mVWUR
	 h8TJ3n7Z6QSivh3hCZX3QkDb3uzSye4MpUyh1IiayV09v2aAIeBWB78tD97VJlU1+1
	 RDABkOq2V5MrlKU8sE2MW6kZYhQ7iyZ3PFAr+zxedi0ySZ149CzAScHr+zquuim18r
	 kPyZKpFf7MYP5ZCy0nOs9v6yTKX7uCk41i+3dET4d8T3IaGMO9Cov+Gc2J/+sPaGrU
	 RBpwsoG7UEn1DnePJvOS/ATacQighvVFsEFPcCGqEpg6kJ9qt63EPcQQ5h9SNn5wFH
	 R1hfC6pBaOorA==
Date: Wed, 08 Jul 2026 09:09:35 -1000
Message-ID: <04d18472125c4e630eb869cc4a353086@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 16/36] sched_ext: Build the set_cmask scratch from trusted geometry
In-Reply-To: <20260707003028.82D7A1F000E9@smtp.kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org> <20260707001229.1410929-17-tj@kernel.org> <20260707003028.82D7A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Tue, 07 Jul 2026 00:30:28 +0000, sashiko-bot@kernel.org wrote:
> - [Low] The functions `scx_cpumask_to_cmask` and `scx_cmask_clear` were left in the codebase despite being completely unused after this patch.

scx_cmask_clear() is still used - a later patch's cap-sync path calls
it, it only looks unused at this point. scx_cpumask_to_cmask() is indeed
now unused; it's a base helper and I'll keep it for now since a future
caller is likely and it's trivial to drop later.

Thanks.

-- 
tejun
