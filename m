Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AADE390993;
	Wed, 29 Apr 2026 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446842; cv=none; b=WZ1i9Hat5jiPsTwpYj+/QiKNhrvYJi/UrI/lSGXC5yfza5ZpKazCjqeOu4pFGSJ/xFldP7tqJfECZc0q5CphIJAEBxvcl8t1uoqOFtyrmVWNwQWOlSQxAx58M4Gs9YOR6oESgF02FCzEFKhM1RAhcQCgIn+HgmSTMnSy3m2IgFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446842; c=relaxed/simple;
	bh=omobsoSyDmyIkjr0MyQmsMSnyef0lkI3kL/jhz+ZQ54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzWO+x3VnSamiFfFFLgcEzfc70bnZsFbc8QVhNC9AzLhk9gWIuo7IepRhzQ8eMJO1idQaxsc8pLP2vZWX+/X8tta0LvTlFRkpwI4OLngX72wO2WiOyewzIn0gx+tXl2prFWYZvK2yNZ08u+eu8n/CpgA6wOEXQEdUEqTrDEDXbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVDyZODr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVDyZODr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A293C2BCB3;
	Wed, 29 Apr 2026 07:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777446842;
	bh=omobsoSyDmyIkjr0MyQmsMSnyef0lkI3kL/jhz+ZQ54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nVDyZODrBgg/Pe7YJN6wN5CYj/ESIglycn831Vo1ptlO0egOflhDmpDEVx+v/Yzrt
	 syKMl4JziSwtjECby2kMh9312q89sE7S63HnteSp6KaCJqCDyeSx26UxP0ruFZQmSm
	 y0ReZ4xT1WIWfb18Yrt0FK/Z3WkLpFFhyXCtqKgTLBJ+/Uzx5fbUzuJ7TW7ZdSXYQZ
	 pbFFA4qb02ZNshbXOIr0Zlzx/vNsIlV8sMbxlFZImBVJOBpCx+tFJ2bZzGcnenfanF
	 e+fUfv1bLaCmpz9Fvi1QfShiVulFPUnW4o/4sz4jtHJk5lz46C+USoY7nkiacbvdCd
	 MBf6bAEjAaaeQ==
Date: Tue, 28 Apr 2026 21:14:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: void@manifault.com, arighi@nvidia.com, kernel-dev@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] sched_ext: Dump the exit CPU first
Message-ID: <afGvufr6kLYiAbhm@slm.duckdns.org>
References: <20260429060726.359024-1-changwoo@igalia.com>
 <20260429060726.359024-3-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429060726.359024-3-changwoo@igalia.com>

On Wed, Apr 29, 2026 at 03:07:25PM +0900, Changwoo Min wrote:
>  static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
> -		      s64 exit_code, const char *fmt, va_list args);
> +		      s64 exit_code, int exit_cpu, const char *fmt,
> +		      va_list args);

It's a bit mixed throughout the code but let's use s32 for cpu. Otherwise,
the series looks good to me.

Thanks.

-- 
tejun
