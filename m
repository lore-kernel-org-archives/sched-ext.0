Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFE92D2483;
	Wed, 22 Apr 2026 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776878338; cv=none; b=sNpciYAyMkztynACOaAKjKIXGIyscB5eupFOuCadLvv8Y/PYtgMP8k239Ku/hyIFda9qhz3EU6BvfaavZTnkjnK7CWAl7riy4wjb9yRQwlMjGSBqGErLJAu93qNzKJHd/YCX+txHbg90QJ3zaScF1541gnaoE2ZY/3bPQElP7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776878338; c=relaxed/simple;
	bh=FiYQa7tnRLyTpJd8T5DYYtmAKyOHGq337bdQwXrjTX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKBzWWxsxhU2zKfgkpNbGjBjep1auIWlePnLFFfvWsTr96nxkHjEH5JwOD/mgn2rtlBZ6TfVk1x+nL5HLRYb+aUmDcvRahvqKbBJRNHWLn7/7M8g4mgjuOWuvcxLeNLzYDLWan3Ga6AcFV01M5MVgWvtvv5A/WpoDSwRuhefNcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZb0AAtt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZb0AAtt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FB0C19425;
	Wed, 22 Apr 2026 17:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776878338;
	bh=FiYQa7tnRLyTpJd8T5DYYtmAKyOHGq337bdQwXrjTX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qZb0AAttHkohmh/8tCxKykx78MJOuXRQhJupp76IsR/DVFCXON88tX+p9i2Iu003c
	 dvFBxjL9bv3Z8hXlQGp/5XNLMT/teHDhUbkf1RpkI9XKv59CkRdgd6H/ZjpJ30fvQI
	 llby9Ou9c6oy+5AP3GzlkJJLpJMfFs/YdlXKfGOzs7qv7wytkQ1ilPAQ4f73uu/jzH
	 lCEUZdAOwD3ZYEJHLBIzCm1096r6OfO5C6k/EBzlDgVll4igvq2+M1m7cJo6Eb/Xay
	 yITxVweSwofuUzkRgjeXFnuAnnwUE3BilTPEG5UComNAzrflmlnQDKkcFHdwxIOshv
	 YmI2JeylGO1hw==
Date: Wed, 22 Apr 2026 07:18:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Refactor
 scx_root_enable_workfn() enablement task migration
Message-ID: <aekDAe7GV99mRM7l@slm.duckdns.org>
References: <20260421074154.584737-1-yphbchou0911@gmail.com>
 <6cccef586daa450e322d9659d4e64e13@kernel.org>
 <20260422094555.Gaec7@cchengyang.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422094555.Gaec7@cchengyang.duckdns.org>

On Wed, Apr 22, 2026 at 09:53:24AM +0800, Cheng-Yang Chou wrote:
> Regarding the ordering of the task enablement sequence: do you think
> it would be useful to be included in the kdoc?

Who'd be the audience tho? This isn't a level of detail that'd be
interesting to people who want to use SCX. For kernel devs, I don't think a
doc which just restates the code sequence is all that useful when you can
just throw an AI agent at it and get the same and more in no time.

-- 
tejun
