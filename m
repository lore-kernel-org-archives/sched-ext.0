Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF14B35958;
	Sun, 22 Mar 2026 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774209987; cv=none; b=aXHhUEb8xsphwzZfSG6nzezt9u5FL2bgbXCFSRveepKsz0DWB/gmqGhntnOAHh4kilRzN3j8NOB8ntipCL+diyUcQYKHlqtisrBZqMOt2cDwBQQurbusLu1qphek/NvXNORejP8GqCS67mpS7lVLG8c6cOOVtLx8YsL2MBg/rCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774209987; c=relaxed/simple;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=IIbQZSkj5cpkmk6dqRe73BFDGd7a6OjpTIRr4s//p5iiaoVUKEuYWzCyZTPIgSIC9NwZpDzJxI81Rb9iE/sS1K4A9N1GHscxTpFDUTSSNnDIuTRMnx0AVrEDAW0mzAYfMpzNeDqq/tCypmmpAIPhf+4AKVE11ylDyvDsQz2sxF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umhKHvcN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umhKHvcN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C31EC19424;
	Sun, 22 Mar 2026 20:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774209987;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=umhKHvcNvDbZGx01yl+bAwlhGAi7g6EoQzpKOCrKZFWw9VmgXdAo7fhOedx2Wcf4I
	 zuAsXGKERqbvqKNkR57ZbwCpxpSZiORpuADisSwRZ8Tf2/NlBWLL+D7mzveRznH/to
	 yH1JtqONJyYIxKpHakKND0WepjesBpLVR4ry8mbW/HrQLQL5eUOc6zYLc00wbQByLj
	 X+YkvNtLGWQ/T0yxcwUyKxK/wW+cPouMflizEYM522jopTHSO3Ox0GyK3E3dj7iP+k
	 OTyndjAi4QD7OSBUVm5SMJPmdRAKL/gZLOhEaQNBOroFj4fevCojz4c53pN9jMxD0z
	 jFjP2pR+W2ExQ==
Date: Sun, 22 Mar 2026 10:06:26 -1000
Message-ID: <b66598a5d95ec90b184d15fff8b510fd@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 Andrea Righi <arighi@nvidia.com>,
 sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 kernel test robot <lkp@intel.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.1] sched_ext: Fix build errors and
 unused label warning in non-cgroup configs
In-Reply-To: <20260322134900.1641781-1-yphbchou0911@gmail.com>
References: <20260322134900.1641781-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
