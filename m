Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56505357D12;
	Tue, 12 May 2026 21:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620698; cv=none; b=nfUDRhaYl6O2+ikPsiHi2XQHnTJUgpTs4Kn+A/NTMVSEsw5kFZYOUljiPpdWiJS7jehwe3Qtzo+Zkox4Uqa7a6YoPw6OOUEF+1CsCATg67Gn7zuIoRb5OT8oZCBRjlDoYBdtHsN7wt4qURRjoBl5grYvdwrocdALW4xxRpS1gac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620698; c=relaxed/simple;
	bh=xkv4rowQSbrlz+DtnyHzM6Q4ND/p6P6zl8wnb2i6vJM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Qiu+UXqX5kRbXZZWLk5/as8qT58WPWAB2iTo2EALmfQ2kiEfM01G3wU+nIU5J3uXW4IlYcYqeA0sRJtpw5zkKQgK3OOfqEgif/n80PqwIPRod2zHMaSkUkXT0Sy7utUSvVunjN4/psnoZNqsjW7OBXpfeM/FoVDPOy6dl9Fx26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbWjhTTr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbWjhTTr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22BFC2BCB0;
	Tue, 12 May 2026 21:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778620697;
	bh=xkv4rowQSbrlz+DtnyHzM6Q4ND/p6P6zl8wnb2i6vJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DbWjhTTrAx5+ivTciMw9t6JEFdrzoT36L1KcIbNZre2p7jo3s/sAMhGnY+P62vPIN
	 Ab0R1M90JU9Ty8FHbTSYRBRcd7ehIDMVEjKEF2gdxF3+goUUvdVLoavp84kry64P7/
	 smFM1GdgldAUBcb+grbqctDT8Gccj2Z4/PfV0Ug4KabCjiXUNQgpY22uP+xbroxzCD
	 YOAFJOqrRB6WF2dzCg9wev0DjgzqhxU0Rp36Kl+DNdfZcI+MDp+ccfKZUOAFrVM0DQ
	 FaYJ03X6XZk71NUJbyvhx8M6MD70fV8jgTdR59RNrv17UVIaCl7IhR+dicGnk1DmX+
	 BlDU8mkQTlRGg==
Date: Tue, 12 May 2026 11:18:16 -1000
Message-ID: <6130fb602240f8f5e0c65fcbce509334@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com
Cc: sched-ext@lists.linux.dev, emil@etsalapatis.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.1-fixes] sched_ext: Drop NONE early return in scx_disable_and_exit_task()
In-Reply-To: <20260512211102.883417-1-tj@kernel.org>
References: <20260512211102.883417-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1-fixes.

Thanks.

--
tejun
