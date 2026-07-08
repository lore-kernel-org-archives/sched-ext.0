Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943603033CB;
	Wed,  8 Jul 2026 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535789; cv=none; b=ow3kWeEPfM41R69ziWHD7N+1TELX0N1Rb8qrO6MH6tSRFcfz51unqtkagIafHViVW9HoRuXVzitxd+svDAHnjtXYX9V6KxcoB7oBHtuwdKFyqiTTMToUC8W0b7SfRkpIMoqxbSCM6klZKJgJbwOzZSnJmShGgb4faJAXfOXFWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535789; c=relaxed/simple;
	bh=qdYU/bSf6LLadGni+Kxk1fW265eoaZs78Yoz5MHEv2k=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=CdRqcJlF9PUoLqDZ8LysR9e1iITyooKKvGQdj7BKeDd/SUmUG3neV1/XeV8c0421cRyLaPL2e0S8JRZ2rOwjMfkLUC747mPOejlTLU3K+/YVXYTv4IZOX3H7muGoyIq+E+NyMsDKXUj9RGClFq+KzaRw37iWTfE+hZks7JL2iTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuNdBILY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuNdBILY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E4C1F000E9;
	Wed,  8 Jul 2026 18:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783535788;
	bh=qdYU/bSf6LLadGni+Kxk1fW265eoaZs78Yoz5MHEv2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GuNdBILYn7c+/r3o6Kon32HcNJa2f6X3k18B5E5+jQ1FvmdbPUsne8eRxO5gmvsNj
	 eoBDI1si7A/XROtcKZAeoh1TPPC3QronGXzanUQecxNw7XxKXMwAfktgv1dL2n3G5G
	 VfKsPEykpFEyTM/sewthhgHcWX1AP5RPpmVv6etq9FZwyLwC2PLwcB/0vItAaEfBu5
	 5qK8Sd17Kt6Uvlx19b8+XTgSYxTulNfBKOIUsvBvVtgfO9BBQzEOIAefTH9jYnkyU2
	 1Ir0SyF+NCmU0fHmx/2s5tcdkIdq51aMd/mvZEg7AI95V7+si8aQmLuqlgqYnZNdwe
	 gOHCd/HjsKlvw==
Date: Wed, 08 Jul 2026 08:36:27 -1000
Message-ID: <01d46d590896031df08e5b936176af4a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.2-fixes] sched_ext: Preserve rq tracking across local DSQ dispatch
In-Reply-To: <20260708084327.1088186-1-arighi@nvidia.com>
References: <20260708084327.1088186-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.2-fixes.

Thanks.

--
tejun
