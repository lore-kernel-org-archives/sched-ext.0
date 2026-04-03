Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD5D3803DA;
	Fri,  3 Apr 2026 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775238611; cv=none; b=lw32zSyIbwvMNsGzLf2GdgQXX6hN/yub5lDH2Gb5CfWP+RgjfwbIXzj6T77dgQlOKaEzDzayHNlutR7xsCF23kzFg0jfCKkluy5iX2D79NeFaAt2idSx/1tm5bn5gUh1dlVQPv2ncszCixiGb3OnExUFdLlAOENTDM9s5NGFwkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775238611; c=relaxed/simple;
	bh=+LJdDIM9luDZaeji34S+t9PsTLT9XrdlWVRFEm28u2c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=FvxFpZ6EQG+fXzRCT5wkAijGA77Qu23oLl7I+hZL3uQyWw1C2Rf+tiwGAFLV7FjSuYlCtrPy7K8re2mBezezAfIOftkhJWAf+XZ299+EEzQ4McIyry9o32c45HmoTr27LLxIJ40Y8DNd1cHmK0g2IEu9qTTn9esmqsKqA0J53cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOj5UKi8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOj5UKi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023AAC4CEF7;
	Fri,  3 Apr 2026 17:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775238611;
	bh=+LJdDIM9luDZaeji34S+t9PsTLT9XrdlWVRFEm28u2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nOj5UKi8m8R8CErMhv8AkdnsjMmSpSNcsnWBnTURIwtXg/belkDesqbaIjd8dCiFk
	 SMLQhEkn4K6jdki/yYu6GRmrLv2dG4GXT4FFY9VQVSSd42LwQy863/thm0DD38+10g
	 aKMjMo12LeNUkBcP1+qnoAzQdNFDzRVl6O3VxkLs/UzN9L5UwPtOUR8VT6JTKEEdh+
	 vmnJmkmw1hxTsWHv7w2i83T9UPCB648OIqEvruGb6PEbF9w1DpNfKZ0U71UCRsWNOX
	 EGWbnADXgWZPLOqa9wsKeJO81JtybBuB6sxR+trhthoenfaxpBIA3TiGUhmjXgpght
	 GS/nZn5tGUE0A==
Date: Fri, 03 Apr 2026 07:50:10 -1000
Message-ID: <7bd98cd13ad2e014f455f3ec79c5c660@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>,
 Daniel Hodges <hodgesd@meta.com>,
 Patrick Somaru <patsomaru@meta.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched_ext: Fix stale direct dispatch state in
 ddsp_dsq_id
In-Reply-To: <20260403065720.1605109-1-arighi@nvidia.com>
References: <20260403065720.1605109-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.0-fixes with the Fixes tag SHA trimmed to 12
characters.

Thanks.

--
tejun
