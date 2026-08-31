Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A8F470116;
	Mon, 31 Aug 2026 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197497; cv=none; b=iRM/K15Tt+guyx/GRJBi09g+TAOPhgEeRl0ie1ozrQ7WSGvAcqWXjCbhq+Z5v0+tcuWFb4PV22ITdlifvczYJgiPjyx8YHtoTbgsCZq+h72jVTW0AzAnJoEqIQmsWbyN5BGaOZzDWod8NNaXGliLYIJrj9ynQabA5lEx7rdOnGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197497; c=relaxed/simple;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=G5mZTtd4866O3aEEIUPV38r+YZLcdBdFH6Yjir3iaziJ1jfUEpEGB1BpVVQ2Ym4qlymXRDHNtMEqulH8q9TQLsQK7Bp0YwSPruiaTTWzs0i7tTPXy3GjY3TrzgowA+BGh7l0FrlZLlktc+jKSnk1mVKtAI2YCJWPM1VN/CLyCFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUEiX/F7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUEiX/F7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF2A1F000E9;
	Mon, 31 Aug 2026 17:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788197496;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HUEiX/F7FtLjDf9CzWpxa/Bab2DNLUJfZVUhmSOROk0jaRbqHyoGgmADih9UDVL0e
	 6KUQYyQwnVCkIJjorn7t+HXjKBjOwzscz3SYm9z6qigd5gWqWfRuGmOAxt5Ovlhoiz
	 473raszWIt2aZXcGYcBE/RgdxL8zDSIBIjIwkEHF/cmNrqDzlbjcAsJ8LtqBiWR2ij
	 Fns38WmKgm/FAvWbBNRi9VhT7CFKfLWoPqD1iDbW8vUPaIgqVPGUBU7gxeVcuLslCg
	 /0ibIkbXNlcNJlj195Q71q6BS5C+rGjuBuYIv9KMernsyGtDjzmNCfPLJEOlGlNjpt
	 zb95SZRLrI5bg==
Date: Mon, 31 Aug 2026 07:31:35 -1000
Message-ID: <24375e8af5b560d192f48a251d7db69e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Liang Luo <luoliang@kylinos.cn>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix missing @slice and @vtime descriptions
 in finish_dispatch() kernel-doc
In-Reply-To: <20260825055053.2295139-1-luoliang@kylinos.cn>
References: <20260825055053.2295139-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3-fixes.

Thanks.

--
tejun
