Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308422BE7BE;
	Sat, 11 Apr 2026 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775893311; cv=none; b=QHLAYR4B20bMBr+lJt1MFDa3Ig+Q3+rNVk2PLpMo4LXmNwp0S+d4PjZBZhUkusQvE/JgJIoCd2N0NDZSXHSPzn2t6CXDz2iPbawVHsfgREkZda19DMMHvrycmLImFRdJJd+6WA6O7MJVAPE0+n/L9mtAvqmbGG+o20EWabuW7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775893311; c=relaxed/simple;
	bh=wwTxpA4NBILATgz7FTWAA6hz6dCtwvfohlz42g2RSN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqW1MBmc7p9Dsr/oyONYYjpKEiLsTBhlpy9EoiIct4AKcfJGJYHG/91VHxcFaNgv1aLf+J38aCM3mZg1OSioe4zEEPqlz3HY6zK6A/wf6O9yft+E4i85vyYHRVdCsW4Jpr1Cv3A9s6zO2AJWLfLqchyUURYjX7xA9EVramE7ttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfFfgSq8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfFfgSq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E6FC4CEF7;
	Sat, 11 Apr 2026 07:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775893310;
	bh=wwTxpA4NBILATgz7FTWAA6hz6dCtwvfohlz42g2RSN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfFfgSq8BUFQ9kdpjmkIAclwrS4nrUdgSSf7NekJrEhksM/McbCCi8pW2SRjP293c
	 R84ArIqst2t+gcRsXIuKl15wdfyrhuF1pKSNdjHWMl2tDEaB42unhPo3qUkfK2UarH
	 8yBxq1tQ6kXGUqLbUBXJbtugjak1X/65v/7ZW58CwyTLnDlBkRcHKo3hLZLxWtvZLn
	 5OqRfYf8/3dc6YA49jY9GksDoWU1Jm3UPwyUjzsafowc3S9k46n5ec1XVZVO1YvR+t
	 JqYYscsOVCb4H67LCesMbxiOvQXMx8fZyTo6Macp8ReQ8krfJKhuAtBc83IvOoPVbO
	 RahIr60cOS+mQ==
Date: Fri, 10 Apr 2026 21:41:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Andrea Righi <arighi@nvidia.com>, sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.1] sched_ext: Add verifier-time kfunc
 context filter
Message-ID: <adn7PVYWR2FVnqFQ@slm.duckdns.org>
References: <20260410063046.3556100-1-tj@kernel.org>
 <adk3PF5tJOwJbeop@gpd4>
 <aa6dotiucffrhwylwuwezvmtkew5ekzcnpt2eb4vvf2yquame4@ewd3arfzvozy>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6dotiucffrhwylwuwezvmtkew5ekzcnpt2eb4vvf2yquame4@ewd3arfzvozy>

Hello,

On Sat, Apr 11, 2026 at 02:17:37PM +0800, Cheng-Yang Chou wrote:
> Regarding selftests: do we need to add any for this series?
> It was brought up during the review of Juntong's v3 patch,
> but I haven't seen any further responses regarding this on my v4 patchset.

It would be nice to have a test covering all combinations of allow/deny
matrix and that's how I tested but I'm not sure there currently is a good
way to include such tests in the current testing framework.

Thanks.

-- 
tejun
