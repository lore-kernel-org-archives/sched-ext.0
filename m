Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A162EBDFA;
	Tue, 14 Apr 2026 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776187514; cv=none; b=VW2rQHWLGzT078YzB07a4EmIOXsd6/lEPVtjr52hef8dyLKoUpNwPg7+ZRshA0unJPbqH7VzKLtOEEhuXuE+4mAINgi0ULDQW1C51W485tNxmhbJW5ZedTDSkzDc85lGPgWd20olT6XpBdRQlqQgFQ3eckwYfZ5xZK9XF2boiwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776187514; c=relaxed/simple;
	bh=JknRXhnLwg1zvRV4I5BwQl4AvVb40pjbC8B3wsjNNzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfBxSLX/3w++X2IkzZsZoxfUAoS1XsQkdK1vAxvl1NN+FvPFnYKKY46GpbWVWKLfXU2Tg+FNXI5HlGdPYZQlkkqt/O9u5K8CaCWhEoVZNoCRO9RlnQz6m1JB+ehlaocOEUcreK2hS+kXz22LgFUVTLe7tcj9Ck37FCzzfa+tqOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozW4t1/0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozW4t1/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87198C19425;
	Tue, 14 Apr 2026 17:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776187513;
	bh=JknRXhnLwg1zvRV4I5BwQl4AvVb40pjbC8B3wsjNNzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozW4t1/0Rr/MA5I7YPOdPIg17vMOXgT/MPrhLZutnBYknWgmcIYEtahRDFHFkEe67
	 9rZ5xZUo3/lpYR41BE/NYOo39o7Ap0Z2w21Kph9nHcaJegsuhKfcmjMmMbO+ZCxq48
	 CFS0obwDwV3i/u3sIRLlvK069JfUqMkt4VKXd5KBkG148YuqJ62yvC+xEc3HRbT8oy
	 fUynw0hcfYThWHyOVteE4ISpbkm0AeXvNb5KpEMd7BSoUUyhu/+hWGBS9VADm4QGtr
	 asnUaZ0Pj7kvXYOIIWqNI0M6sVvAElU2TLz5I1zJyuy/M4Q8AffHvnpTaXLywHBFR6
	 MNbjy7jUY2LUg==
Date: Tue, 14 Apr 2026 07:25:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] sched_ext: Add verifier-time kfunc context filter
Message-ID: <ad54eNgC_xPk-0XL@slm.duckdns.org>
References: <20260410063046.3556100-1-tj@kernel.org>
 <20260410063046.3556100-8-tj@kernel.org>
 <f2ab3yg5niso6hxqe7sd4jmv5xzdizk3khcspm5bylfbn3mj44@tpyiezvs4cod>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ab3yg5niso6hxqe7sd4jmv5xzdizk3khcspm5bylfbn3mj44@tpyiezvs4cod>

On Tue, Apr 14, 2026 at 08:38:37PM +0800, Cheng-Yang Chou wrote:
> So I think we should do the following:
> 
> 1. Add a filter to deny all context-sensitive kfuncs for non-SCX
>    struct_ops programs, not just the rq-locked ones.
>    This makes the runtime OOB in scx_prog_sched() unreachable.

Yeah, let's do that.

Thanks.

-- 
tejun
